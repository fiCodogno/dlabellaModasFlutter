import 'package:dlabella_modas/models/user_model.dart';
import 'package:dlabella_modas/screens/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: const Text("Login"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const CreateAccountScreen()));
              },
              icon: const Icon(
                Icons.create,
                color: Colors.white,
              ))
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: ((context, child, model) {
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
                  obscureText: true,
                  cursorColor: Colors.pink.shade700,
                  decoration: InputDecoration(
                      hintText: "Senha",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700))),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: const ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(
                          Color.fromARGB(52, 194, 24, 92)),
                      padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                    ),
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 2),
                            backgroundColor: Colors.redAccent.shade700,
                            content: const Text(
                              "Preencha o campo email para solicitar a recuperação de senha!",
                              style: TextStyle(color: Colors.white),
                            )));
                      } else{
                        model.recoverPass(_emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 2),
                            backgroundColor: Colors.greenAccent.shade700,
                            content: const Text(
                              "Email de recuperação enviado!",
                              style: TextStyle(color: Colors.white),
                            )));

                      }
                    },
                    child: Text(
                      "Esqueci a Senha",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.pink.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
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
                        model.signIn(
                          email: _emailController.text,
                          pass: _passwordController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                        );
                      }
                    },
                    child: const Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  void _onSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.greenAccent.shade700,
        content: const Text(
          "Usuário logado com sucesso!",
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
          "Falha ao logar o usuário!",
          style: TextStyle(color: Colors.white),
        )));
  }
}
