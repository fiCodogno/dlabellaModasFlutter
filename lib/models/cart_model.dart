import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlabella_modas/datas/cart_product_data.dart';
import 'package:dlabella_modas/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  List<CartProductData> products = [];

  String? couponCode;
  int discountPercentage = 0;
  bool isLoading = false;

  CartModel(this.user) {
    if (user.isLoggedIn()) {
      _loadCartItems();
    }
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProductData cartProduct) {
    products.add(cartProduct);

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cartId = doc.id;
    });

    notifyListeners();
  }

  void removeCartItem(CartProductData cartProduct) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .doc(cartProduct.cartId)
        .delete();

    products.remove(cartProduct);
    notifyListeners();
  }

  void addUnitCartItem(CartProductData cartProduct) {
    cartProduct.quantity++;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .doc(cartProduct.cartId)
        .update(cartProduct.toMap());

    notifyListeners();
  }

  void removeUnitCartItem(CartProductData cartProduct) {
    cartProduct.quantity--;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .doc(cartProduct.cartId)
        .update(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItems() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .get();

    products =
        query.docs.map((doc) => CartProductData.fromDocument(doc)).toList();

    notifyListeners();
  }

  void setCoupon(String? couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CartProductData cartProduct in products) {
      if (cartProduct.productData != null) {
        price += cartProduct.quantity * cartProduct.productData!.price;
      }
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * (discountPercentage / 100);
  }

  double getShipPrice() {
    return 9.90;
  }

  void updatePrices() {
    notifyListeners();
  }

  Future<String?> finishOrder() async {
    if (products.isEmpty) {
      return null;
    }

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder =
        await FirebaseFirestore.instance.collection("orders").add({
      "clientId": user.firebaseUser!.uid,
      "products": products.map((cartProduct) => cartProduct.toMap()).toList(),
      "shipPrice": shipPrice,
      "productsPrice": productsPrice,
      "discount": discount,
      "totalPrice": productsPrice + shipPrice - discount,
      "status": 1
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("orders")
        .doc(refOrder.id)
        .set({"orderId": refOrder.id});

    QuerySnapshot query = await FirebaseFirestore .instance.collection("users").doc(user.firebaseUser!.uid).collection("cart").get();
    for(DocumentSnapshot doc in query.docs){
      doc.reference.delete();
    }

    products.clear();
    discountPercentage = 0;
    couponCode = null;
    isLoading = false;
    notifyListeners();

    return refOrder.id;
  }
}
