import 'package:dlabella_modas/tabs/home_tab.dart';
import 'package:dlabella_modas/tabs/orders_tab.dart';
import 'package:dlabella_modas/tabs/places_tab.dart';
import 'package:dlabella_modas/tabs/products_tab.dart';
import 'package:dlabella_modas/widgets/cart_button.dart';
import 'package:dlabella_modas/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        Scaffold(
          floatingActionButton: const CartButton(),
          drawer: CustomDrawer(_pageController),
          body: const HomeTab(),
        ),
        Scaffold(
          floatingActionButton: const CartButton(),
          appBar: AppBar(
            backgroundColor: Colors.pink.shade200,
            centerTitle: true,
            title: const Text(
              "Produtos",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          drawer: CustomDrawer(_pageController),
          body: const ProductsTab(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink.shade200,
            centerTitle: true,
            title: const Text(
              "Lojas",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          drawer: CustomDrawer(_pageController),
          body: const PlacesTab(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink.shade200,
            centerTitle: true,
            title: const Text(
              "Meus Pedidos",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          drawer: CustomDrawer(_pageController),
          body: const OrdersTab(),
        ),
      ],
    );
  }
}