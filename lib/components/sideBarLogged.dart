import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiwai_dictionary/components/sidebar_buttons.dart';
import 'package:waiwai_dictionary/screens/about.dart';
import 'package:waiwai_dictionary/screens/home.dart';

class SideBarLogged extends StatefulWidget {
  const SideBarLogged({super.key});

  @override
  State<SideBarLogged> createState() => _SideBarLoggedState();
}

class _SideBarLoggedState extends State<SideBarLogged> {
  String user = "Marcos";

  @override
  Widget build(BuildContext context) {

    logout() async{
      //usuario vai remover o token do local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('logado', false);
    }

    callDict() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }

    callAbout() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Sobre(),
        ),
      );
    }

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Image(
              width: 230,
              image: AssetImage("assets/tapotaLogo.png"),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SidebarButton(
                          onTap: callDict,
                          text: "dicionario",
                          icone: Icons.menu_book_rounded,//melhorar Icone
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SidebarButton(
                          onTap: () {},
                          text: "Atualizar",
                          icone: Icons.cloud_download_outlined,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SidebarButton(
                          onTap: callAbout,
                          text: "Sobre",
                          icone: Icons.info_outline_rounded,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SidebarButton(
                      onTap: null,
                      text: "Bem-Vindo $user",
                      icone: FontAwesomeIcons.circleUser,
                    ),
                    SidebarButton(
                      onTap:logout,
                      text: "sair",
                      icone: Icons.logout_outlined,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
