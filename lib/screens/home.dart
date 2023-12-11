//Tela onde vai ficar direcionador dicionario ou tradutor
import 'package:flutter/material.dart';
import 'package:waiwai_dictionary/screens/login.dart';

//Tela Para escolher Dicionario OU Tradutor
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //Chamar dicionario

    //Deslogar do sistema
    logout() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false, // Remove todas as rotas existentes da pilha
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[200],

//Image
        title: const Image(
          image: AssetImage("assets/dicName.png"),
          height: 120,
          width: 120,
        ),
      ),

//Side Bar
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            
            const DrawerHeader(
              child: Image(
                image: AssetImage("assets/tapotaLogo.png"),
              ),
            ),

//SideBar Buttons
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.cloud_download_outlined,
                    color: Colors.black,
                    size: 37,
                  ),
                  label: const Text(
                    'Atualizar',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),

                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.black,
                    size: 37,
                  ),
                  label: const Text(
                    'Sobre',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),

                TextButton.icon(
                  onPressed: () {
                    logout();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 37,
                  ),
                  label: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      //App Body
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [],
        ),
      ),
    );
  }
}
