import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen(this.orderId, {super.key});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        centerTitle: true,
        title: const Text(
          "Pedido Realizado",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_satisfied_outlined,
              color: Colors.pink.shade700,
              size: 80,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Pedido realizado com sucesso!",
              style: TextStyle(
                  color: Colors.pink.shade700,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Código do pedido: $orderId",
              style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
