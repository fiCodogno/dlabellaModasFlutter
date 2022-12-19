import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlabella_modas/datas/product_data.dart';
import 'package:dlabella_modas/tiles/product_tile.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen(this.snapshot, {super.key});

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink.shade200,
            title: Text(snapshot.get('title')),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.grid_on,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .doc(snapshot.id)
                  .collection('items')
                  .get(),
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
                  return TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        GridView.builder(
                          padding: const EdgeInsets.all(4),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4,
                                  childAspectRatio: 0.65),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductData data = ProductData.fromDocument(
                                snapshot.data!.docs[index]);
                            data.category = this.snapshot.id;

                            return ProductTile('grid', data);
                          },
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.all(4),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductData data = ProductData.fromDocument(
                                snapshot.data!.docs[index]);
                            data.category = this.snapshot.id;
                            return ProductTile('list', data);
                          },
                        )
                      ]);
                }
              })),
    );
  }
}
