// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waiwai_dictionary/screens/home.dart';
import 'package:waiwai_dictionary/screens/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formkey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emaiController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirSenhaController = TextEditingController();
  bool _verSenha = false;
  bool _verSenhaConfirm = false;

  Color alertColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(16),
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

//NOME TEXT FIELD
                    TextFormField(
                      controller: _firstNameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        label: const Text('Primeiro Nome'),
                        hintText: 'Eduardo',
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: alertColor),
                        prefixIcon: const Icon(
                          Icons.person, // Ícone de pessoa para o campo de nome
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (firstName) {
                        if (firstName == null || firstName.isEmpty) {
                          return 'Digite seu nome';
                        } else if (!RegExp(r"^[a-zA-ZÁ-ú]+$")
                            .hasMatch(firstName)) {
                          return 'Nome inválido';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

//ÚLTIMO NOME TEXT FIELD
                    TextFormField(
                      controller: _lastNameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        label: const Text('Último nome'),
                        hintText: 'Silva',
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: alertColor),
                        prefixIcon: const Icon(
                          Icons
                              .person, // Ícone de pessoa para o campo de último nome
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (lastName) {
                        if (lastName == null || lastName.isEmpty) {
                          return 'Digite seu último nome';
                        } else if (!RegExp(r"^[a-zA-ZÁ-ú]+$")
                            .hasMatch(lastName)) {
                          return 'Último nome inválido';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

//EMAIL TEXT FIELD
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: _emaiController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        label: const Text('e-mail'),
                        hintText: 'eduardo@email.com',
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: alertColor),
                        prefixIcon: const Icon(
                          Icons.email, // Ícone de e-mail para o campo de e-mail
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
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

//SENHA TEXT FIELD
                    TextFormField(
                      controller: _senhaController,
                      obscureText: !_verSenha,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: alertColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _verSenha
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _verSenha = !_verSenha;
                            });
                          },
                        ),
                        label: const Text('Senha'),
                        hintText: 'Digite uma senha',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.lock, // Ícone de cadeado para o campo de senha
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (senha) {
                        if (senha == null || senha.isEmpty) {
                          return 'Digite uma senha';
                        } else if (senha.length < 6) {
                          return 'Digite uma senha mais forte';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 12,
                    ),

//CONFIRM SENHA TEXT FIELD
                    TextFormField(
                      controller: _confirSenhaController,
                      obscureText: !_verSenhaConfirm,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: alertColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _verSenhaConfirm
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _verSenhaConfirm = !_verSenhaConfirm;
                            });
                          },
                        ),
                        label: const Text('Confirme sua senha'),
                        hintText: 'Digite uma senha',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons
                              .lock, // Ícone de cadeado para o campo de confirmação de senha
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (senha) {
                        if (senha == null || senha.isEmpty) {
                          return 'Confirme a senha';
                        }
                        if (_senhaController.text.trim() !=
                            _confirSenhaController.text.trim()) {
                          return 'Senhas não coincidem';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

//BOTÂO CADASTRAR
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
                        "Registrar",
                        style: TextStyle(fontSize: 18, color: Colors.black),
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
                          "Já tem conta?",
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.bold), //GoogleFonts
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const LoginPage();
                            }));
                          },
                          child: Text(
                            "Logar Agora",
                            style: GoogleFonts.roboto(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
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
