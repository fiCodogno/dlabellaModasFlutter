import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlabella_modas/datas/cart_product_data.dart';
import 'package:dlabella_modas/datas/product_data.dart';
import 'package:dlabella_modas/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct, {super.key});

  final CartProductData cartProduct;

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      CartModel.of(context).updatePrices();

      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: 120,
            child: Image.network(
              cartProduct.productData!.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartProduct.productData!.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Tamanho ${cartProduct.size}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "R\$ ${cartProduct.productData!.price.toStringAsFixed(2)}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.pink.shade700,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed:
                                  cartProduct.quantity <= 1 ? null : () {
                                    CartModel.of(context).removeUnitCartItem(cartProduct);
                                  },
                              icon: Icon(
                                Icons.remove,
                                color: cartProduct.quantity == 1
                                    ? Colors.grey.shade600
                                    : Colors.pink.shade700,
                              )),
                          Text(
                            cartProduct.quantity.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey.shade900, fontSize: 16),
                          ),
                          IconButton(
                              onPressed: () {
                                CartModel.of(context).addUnitCartItem(cartProduct);
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.pink.shade700,
                              )),
                          TextButton(
                              style: const ButtonStyle(
                                overlayColor: MaterialStatePropertyAll(
                                    Color.fromARGB(52, 194, 24, 92)),
                              ),
                              onPressed: () {
                                CartModel.of(context)
                                    .removeCartItem(cartProduct);
                              },
                              child: Text(
                                "Remover",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.pink.shade700,
                                ),
                              ))
                        ],
                      )
                    ],
                  )))
        ],
      );
    }

    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: cartProduct.productData == null
            ? FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection("products")
                    .doc(cartProduct.category)
                    .collection("items")
                    .doc(cartProduct.productId)
                    .get(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    cartProduct.productData =
                        ProductData.fromDocument(snapshot.data!);
                    return _buildContent();
                  } else {
                    return Container(
                      height: 70,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  }
                }),
              )
            : _buildContent());
  }
}
