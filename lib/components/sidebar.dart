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
    logout() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
    }

    callDict() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false,
      );
    }

    callAbout() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const Sobre(),
        ),
        (route) => false,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SidebarButton(
                  onTap: callDict,
                  text: "Dicionário",
                  icone: FontAwesomeIcons.bookAtlas,
                ),
                SidebarButton(
                  onTap: () {},
                  text: "Atualizar",
                  icone: Icons.cloud_download_outlined,
                ),
                SidebarButton(
                  onTap: callAbout,
                  text: "Sobre",
                  icone: Icons.info_outline_rounded,
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SidebarButton(
              onTap: logout,
              text: "Entrar/Registrar-se",
              icone: FontAwesomeIcons.circleUser,
            ),
          ),
        ],
      ),
    );
  }
}
