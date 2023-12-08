// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waiwai_dictionary/screens/home.dart';
import 'package:waiwai_dictionary/screens/registration.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //LOGO
                const Icon(
                  Icons.android,
                  size: 100,
                ),
                const SizedBox(
                  height: 80,
                ),
                //EMAIL TEXT FIELD
                TextFormField(
                  controller: _emaiController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: alertColor),
                    label: const Text('e-mail'),
                    hintText: 'eduardo@email.com',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Digite seu email';
                    } else if (!RegExp(r"^[a-zA-Z0-9_.+-]+@gmail\.com$")
                        .hasMatch(email)) {
                      return 'Email invalido';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),

                //SENHA TEXT FIELD
                TextFormField(
                  controller: _senhaController,
                  obscureText: !verSenha,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: alertColor),
                    suffixIcon: IconButton(
                      icon: Icon(verSenha
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
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
                  ),
                  validator: (senha) {
                    if (senha == null || senha.isEmpty) {
                      return 'Digite uma senha';
                    } else if (senha.length < 6) {
                      return 'senha muito fraca,\nadicione mais caracteres';
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
                      minimumSize: const Size(40, 40)),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) =>
                            false, // Remove todas as rotas existentes da pilha
                      );
                    }
                  },
                  child: const Text(
                    "ENTRAR",
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                //REGISTRAR AGORA
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Não tem conta?",
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.bold), //GoogleFonts
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const RegistrationPage();
                        }));
                      },
                      child: Text(
                        " Registrar Agora",
                        style: GoogleFonts.roboto(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
