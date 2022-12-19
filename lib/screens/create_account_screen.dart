import 'package:dlabella_modas/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _addressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade200,
          title: const Text("Criar Conta"),
          centerTitle: true,
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: ((context, child, model) {
          if (model.isLoading) {
            return Center(
              child: Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.pink.shade700),
                ),
              ),
            );
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Nome Completo obrigatório!";
                    }
                    return null;
                  },
                  cursorColor: Colors.pink.shade700,
                  decoration: InputDecoration(
                      hintText: "Nome Completo",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700))),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (text) {
                    if (text!.isEmpty || !text.contains("@")) {
                      return "Email inválido!";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.pink.shade700,
                  decoration: InputDecoration(
                      hintText: "Email",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700))),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (text) {
                    if (text!.isEmpty || text.length < 6 || text.length > 16) {
                      return "Senha inválida!";
                    }
                    return null;
                  },
                  cursorColor: Colors.pink.shade700,
                  decoration: InputDecoration(
                      hintText: "Senha",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700))),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _addressController,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Endereço obrigatório!";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.streetAddress,
                  cursorColor: Colors.pink.shade700,
                  decoration: InputDecoration(
                      hintText: "Endereço",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700))),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.pink.shade700)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "address": _addressController.text
                        };

                        model.signUp(
                          userData: userData,
                          pass: _passwordController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                        );
                      }
                    },
                    child: const Text(
                      "Criar Conta",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          );
        })));
  }

  void _onSuccess() {
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.greenAccent.shade700,
        content: const Text(
      "Usuário criado com sucesso!",
      style: TextStyle(color: Colors.white),
    )));
    Future.delayed(const Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.redAccent.shade700,
        content: const Text(
      "Falha ao criar o usuário!",
      style: TextStyle(color: Colors.white),
    )));
  }
}
