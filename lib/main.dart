import 'package:dlabella_modas/models/cart_model.dart';
import 'package:dlabella_modas/models/user_model.dart';
import 'package:dlabella_modas/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(
          builder: ((context, child, model) {
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                title: 'D\'Labella Modas',
                theme: ThemeData(
                  primaryColor: Colors.pink.shade200,
                ),
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
              ),
            );
          }),
        ));
  }
}
