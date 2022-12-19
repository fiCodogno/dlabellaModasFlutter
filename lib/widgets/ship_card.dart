import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlabella_modas/models/cart_model.dart';
import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  const ShipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        iconColor: Colors.grey.shade900,
        leading: Icon(
          Icons.location_on,
          color: Colors.pink.shade700,
        ),
        collapsedIconColor: Colors.pink.shade700,
        title: Text(
          "Frete",
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.grey.shade900,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                cursorColor: Colors.pink.shade700,
                decoration: InputDecoration(
                    hintText: "Digite seu CEP",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink.shade700))),
                initialValue: "",
                onFieldSubmitted: (text) {

                },
              ))
        ],
      ),
    );
  }
}
