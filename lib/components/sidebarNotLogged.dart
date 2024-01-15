import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waiwai_dictionary/components/sidebar_buttons.dart';
import 'package:waiwai_dictionary/screens/about.dart';
import 'package:waiwai_dictionary/screens/home.dart';
import 'package:waiwai_dictionary/screens/login.dart';

class MySideBar extends StatelessWidget {
  const MySideBar({super.key});

  @override
  Widget build(BuildContext context) {
    callLogin() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
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
                          text: "Dicionário",
                          icone: Icons.language_outlined, //melhorar Icone
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
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 18, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SidebarButton(
                  onTap: callLogin,
                  text: "Entrar/Registrar-se",
                  icone: FontAwesomeIcons.circleUser,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
