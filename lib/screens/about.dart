// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiwai_dictionary/components/appBar.dart';
import 'package:waiwai_dictionary/components/cardMember.dart';
import 'package:waiwai_dictionary/components/sideBarLogged.dart';
import 'package:waiwai_dictionary/components/sidebarNotLogged.dart';

class Sobre extends StatefulWidget {
  const Sobre({super.key});

  @override
  State<Sobre> createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    _checkLoginStatus(); // Verificar o status de login ao construir a página

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: MyAppBar(),
      drawer: _isLoggedIn ? const SideBarLogged() : const SideBarNotLogged(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                children: [
                  const Image(
                    image: AssetImage("assets/tapotaLogo.png"),
                    height: 150,
                    width: 150,
                  ),
                  const Text(
                    "“Traduza e se comunique com praticidade!”",
                    textAlign: TextAlign.center,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      """Economize tempo com as suas traduções e concentre-se nas tarefas que realmente importam. Com o WaiwaiTapota, você tem um repertório de palavras da língua indígena WaiWai para o português!""",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Divider(),
                  ),
                  const Text(
                    "Equipe",
                    style: TextStyle(fontFamily: "Nee"),
                  ),
                  TeamPage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Método para verificar o status de login
  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('logado') ??
          false; // Se não existir o status de login, assume como falso
    });
  }
}
