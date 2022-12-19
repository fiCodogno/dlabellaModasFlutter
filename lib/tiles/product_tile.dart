import 'package:dlabella_modas/datas/product_data.dart';
import 'package:dlabella_modas/screens/product_screen.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(this.showType, this.product, {super.key});

  final String showType;
  final ProductData product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProductScreen(product))
        );
      },
        child: Card(
            child: showType == "grid"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 0.8,
                        child:
                            Image.network(product.images[0], fit: BoxFit.cover),
                      ),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "R\$ ${product.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Colors.pink.shade700,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ))
                    ],
                  )
                : Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Image.network(
                          product.images[1],
                          fit: BoxFit.cover,
                          height: 250,
                        ),
                      ),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: TextStyle(
                                      color: Colors.grey.shade900,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "R\$ ${product.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      color: Colors.pink.shade700,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ))
                    ],
                  )));
  }
}
