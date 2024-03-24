// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiwai_dictionary/components/sidebar_buttons.dart';
import 'package:waiwai_dictionary/screens/about.dart';
import 'package:waiwai_dictionary/screens/home.dart';
import 'package:waiwai_dictionary/services/api.dart';

final StreamController<double> progressStream = StreamController<double>();

class SideBarLogged extends StatefulWidget {
  const SideBarLogged({super.key});

  @override
  State<SideBarLogged> createState() => _SideBarLoggedState();
}

class _SideBarLoggedState extends State<SideBarLogged> {
  @override
  void dispose() {
    progressStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final StreamController<double> progressStream =
        StreamController<double>.broadcast();

    logout() async {
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

     getWords(BuildContext context) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Atualizando Dicionário'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                        'Estamos baixando novos dados, por favor, aguarde e não feche o app.'),
                    const SizedBox(height: 20),
                    StreamBuilder<double>(
                      stream: progressStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return LinearProgressIndicator(
                            value: snapshot.data,
                            minHeight: 10,
                          );
                        } else {
                          return const LinearProgressIndicator(
                            value: 0.0,
                            minHeight: 10,
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      );

      try {
        // Realiza o download dos dados
        await fetchDataAndInsertIntoDatabase(onProgress: (progress) {
          // Atualiza o progresso do download através do Stream
          progressStream.add(progress);

          if (progress == 1.0) {
            // Quando o download for concluído, exibe um novo diálogo informando que os dados foram baixados com sucesso
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Download Concluído'),
                  content: const Text('Os dados foram baixados com sucesso!'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }
        });
      } catch (e) {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro'),
              content: SingleChildScrollView(
                  child:
                      Text('Ocorreu um erro durante o download dos dados: $e')),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Fecha o diálogo
                  },
                ),
              ],
            );
          },
        );
      }
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
                          icone: Icons.menu_book_rounded, //melhorar Icone
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SidebarButton(
                          onTap: () => getWords(context),
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
                    const SidebarButton(
                      onTap: null,
                      text: "Bem-Vindo Usuáio",
                      icone: FontAwesomeIcons.circleUser,
                    ),
                    SidebarButton(
                      onTap: logout,
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
