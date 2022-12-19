import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlabella_modas/models/cart_model.dart';
import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        iconColor: Colors.grey.shade900,
        trailing: const Icon(Icons.add),
        leading: Icon(
          Icons.card_giftcard,
          color: Colors.pink.shade700,
        ),
        collapsedIconColor: Colors.pink.shade700,
        title: Text(
          "Cupom de Desconto",
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
                    hintText: "Cupom",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink.shade700))),
                initialValue: CartModel.of(context).couponCode,
                onFieldSubmitted: (text) {
                  FirebaseFirestore.instance
                      .collection("coupons")
                      .doc(text)
                      .get()
                      .then((docSnap) {
                    if (docSnap.exists) {
                      CartModel.of(context).setCoupon(text, docSnap.get("percent"));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.pink.shade700,
                          content: Text(
                            "Desconto de ${docSnap.get("percent")}% aplicado!",
                            style: const TextStyle(color: Colors.white),
                          )));
                    } else {
                      CartModel.of(context).setCoupon(null, 0);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.redAccent.shade700,
                          content: const Text(
                            "Cupom inválido!",
                            style: TextStyle(color: Colors.white),
                          )));
                    }
                  });
                },
              ))
        ],
      ),
    );
  }
}
