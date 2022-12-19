import 'package:dlabella_modas/models/user_model.dart';
import 'package:dlabella_modas/screens/login_screen.dart';
import 'package:dlabella_modas/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer(this.pageController, {super.key});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() {
      return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.pink.shade200, Colors.white],
        )),
      );
    }

    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: const EdgeInsets.only(left: 32, top: 16),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: [
                    const Positioned(
                      top: 8,
                      left: 0,
                      child: Text(
                        "D'Labella\nModas",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: ScopedModelDescendant<UserModel>(
                          builder: ((context, child, model) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Olá${!model.isLoggedIn() ? "!" : ", ${model.userData["name"]}"}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    overlayColor:
                                        const MaterialStatePropertyAll(
                                            Color.fromARGB(52, 194, 24, 92)),
                                    onTap: () {
                                      if (!model.isLoggedIn()) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      } else{
                                        model.signOut();
                                      }
                                    },
                                    child: Text(
                                      !model.isLoggedIn()
                                          ? "Entre ou cadastre-se"
                                          : "Sair",
                                      style: TextStyle(
                                          color: Colors.pink.shade700,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  )
                                ]);
                          }),
                        )),
                  ],
                ),
              ),
              const Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(
                  Icons.location_on, "Encontre uma Loja", pageController, 2),
              DrawerTile(
                  Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}
