import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlabella_modas/tiles/category_tile.dart';
import 'package:flutter/material.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('products').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              height: 200,
              width: 200,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          );
        } else {

          var divideTile = ListTile.divideTiles(
            tiles: snapshot.data!.docs.map((doc) {
              return CategoryTile(doc);
            }).toList(),
            color: Colors.pink.shade700
          ).toList();

          return ListView(
            children: divideTile
          );
        }
      },
    );
  }
}
