import 'package:carousel_slider/carousel_slider.dart';
import 'package:dlabella_modas/datas/cart_product_data.dart';
import 'package:dlabella_modas/datas/product_data.dart';
import 'package:dlabella_modas/models/cart_model.dart';
import 'package:dlabella_modas/models/user_model.dart';
import 'package:dlabella_modas/screens/cart_screen.dart';
import 'package:dlabella_modas/screens/login_screen.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen(this.product, {super.key});

  final ProductData product;

  @override
  State<ProductScreen> createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  int _current = 0;
  final CarouselController _carouselController = CarouselController();
  String size = "";

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        centerTitle: true,
        title: Text(
          product.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
              aspectRatio: 0.9,
              child: CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: false,
                    aspectRatio: 1.0,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                items: product.images.map((imgUrl) {
                  return Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                  );
                }).toList(),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: product.images.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _carouselController.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.pink.shade200
                              : Colors.pink.shade700)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                  ),
                  Text(
                    "R\$ ${product.price.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink.shade700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Tamanho",
                    style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 34,
                    child: GridView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.5),
                      children: product.sizes.map((s) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                size = s;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: s == size
                                      ? Colors.pink.shade700
                                      : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  border: Border.all(
                                      color: s == size
                                          ? Colors.pink.shade700
                                          : Colors.grey.shade500,
                                      width: 2)),
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(
                                s,
                                style: TextStyle(
                                    color: s == size
                                        ? Colors.white
                                        : Colors.grey.shade900),
                              ),
                            ));
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: size != "" ? (){
                        if(UserModel.of(context).isLoggedIn()){
                          CartProductData cartProduct = CartProductData();
                          cartProduct.size = size;
                          cartProduct.quantity = 1;
                          cartProduct.productId = product.id;
                          cartProduct.category = product.category;
                          cartProduct.productData = product;

                          CartModel.of(context).addCartItem(cartProduct);

                          Navigator.of(context).push(
                            MaterialPageRoute(builder: ((context) => const CartScreen())
                          ));
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: ((context) => LoginScreen())
                          ));
                        }
                      } : null,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(size != "" ? Colors.pink.shade700 : Colors.grey),
                      ),
                      child: Text(
                        UserModel.of(context).isLoggedIn() ? "Adicionar ao Carrinho" : "Entre para Comprar",
                        style: TextStyle(color: size != "" ? Colors.white : Colors.grey.shade600, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Descrição",
                    style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    product.description,
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.w300
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
