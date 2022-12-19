import 'package:dlabella_modas/models/cart_model.dart';
import 'package:dlabella_modas/models/user_model.dart';
import 'package:dlabella_modas/screens/login_screen.dart';
import 'package:dlabella_modas/screens/order_screen.dart';
import 'package:dlabella_modas/tiles/cart_tile.dart';
import 'package:dlabella_modas/widgets/cart_price.dart';
import 'package:dlabella_modas/widgets/discount_card.dart';
import 'package:dlabella_modas/widgets/ship_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        centerTitle: true,
        title: const Text(
          "Meu Carrinho",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 8),
            child: ScopedModelDescendant<CartModel>(
                builder: ((context, child, model) {
              int p = model.products.length;
              return Text(
                "$p ${p == 1 ? "ITEM" : "ITENS"}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              );
            })),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
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
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_shopping_cart,
                    color: Colors.pink.shade700,
                    size: 80,
                  ),
                  const SizedBox(height: 16,),
                  Text(
                    "Faça login para adicionar produtos!",
                    style: TextStyle(
                        color: Colors.pink.shade700,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16,),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        ); 
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.pink.shade700)
                      ),
                      child: const Text("Entrar", style: TextStyle(fontSize: 18),),
                    ),
                  )
                ],
              ),
            );
          } else if(model.products.isEmpty){
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sentiment_dissatisfied_outlined,
                    color: Colors.pink.shade700,
                    size: 80,
                  ),
                  const SizedBox(height: 16,),
                  Text(
                    "Nenhum produto no carrinho!",
                    style: TextStyle(
                        color: Colors.pink.shade700,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else{
            return ListView(
              children: [
                Column(
                  children: model.products.map((product) {
                    return CartTile(product);
                  }).toList(),
                ),
                const DiscountCard(),
                const ShipCard(),
                CartPrice(() async {
                  String? orderId = await model.finishOrder();
                  if(orderId != null){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => OrderScreen(orderId))
                    );
                  }
                }),
              ],
            );
          }
        },
      ),
    );
  }
}
