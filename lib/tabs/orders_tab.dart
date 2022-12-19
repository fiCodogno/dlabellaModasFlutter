import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlabella_modas/models/user_model.dart';
import 'package:dlabella_modas/screens/login_screen.dart';
import 'package:dlabella_modas/tiles/order_tile.dart';
import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      String uid = UserModel.of(context).firebaseUser!.uid;

      return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("orders")
            .get(),
        builder: ((context, snapshot) {
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
            return ListView(
              children: snapshot.data!.docs.map((doc) => OrderTile(doc.id)).toList().reversed.toList(),
            );
          }
        }),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.highlight_remove_sharp,
              color: Colors.pink.shade700,
              size: 80,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Faça login para visualizar seus pedidos!",
              style: TextStyle(
                  color: Colors.pink.shade700,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.pink.shade700)),
                child: const Text(
                  "Entrar",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
