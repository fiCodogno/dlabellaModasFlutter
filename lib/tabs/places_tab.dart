import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlabella_modas/tiles/place_tile.dart';
import 'package:flutter/material.dart';

class PlacesTab extends StatelessWidget {
  const PlacesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection("places").get(),
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
        } else{
          return ListView(
            children: snapshot.data!.docs.map((doc) => PlaceTile(doc)).toList(),
          );
        }
      },
    );
  }
}
