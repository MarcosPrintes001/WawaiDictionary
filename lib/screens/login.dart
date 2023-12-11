// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:waiwai_dictionary/screens/home.dart';
import 'package:waiwai_dictionary/screens/registration.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Tela de login de usuário
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _emaiController = TextEditingController();
  final _senhaController = TextEditingController();
  bool verSenha = false;

  @override
  Widget build(BuildContext context) {
    Color alertColor = Colors.orange;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/backGroud.png"),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //LOGO
                    const Image(
                      image: AssetImage('assets/tapotaLogo.png'),
                      height: 150,
                      width: 170,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

// EMAIL TEXT FIELD
                    TextFormField(
                      controller: _emaiController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: alertColor),
                        label: const Text('e-mail'),
                        hintText: 'eduardo@email.com',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: const Icon(
                          FontAwesomeIcons
                              .envelope, // Ícone de carta para e-mail
                          color: Colors.grey,
                        ),
                      ),
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Digite seu email';
                        } else if (!RegExp(r"^[a-zA-Z0-9_.+-]+@gmail\.com$")
                            .hasMatch(email)) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

// SENHA TEXT FIELD
                    TextFormField(
                      controller: _senhaController,
                      obscureText: !verSenha,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: alertColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            verSenha
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              verSenha = !verSenha;
                            });
                          },
                        ),
                        label: const Text('senha'),
                        hintText: 'Digite sua senha',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: const Icon(
                          FontAwesomeIcons.lock, // Ícone de cadeado para senha
                          color: Colors.grey,
                        ),
                      ),
                      validator: (senha) {
                        if (senha == null || senha.isEmpty) {
                          return 'Digite uma senha';
                        } else if (senha.length < 6) {
                          return 'Senha muito fraca,\nadicione mais caracteres';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    //BOTÂO LOGAR
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(40, 40),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 30,
                        ),
                        fixedSize: const Size(320, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: const Text(
                        "Entrar",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //REGISTRAR AGORA
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(40, 40),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 30,
                        ),
                        fixedSize: const Size(320, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationPage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Registre-se",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
