import 'package:flutter/material.dart';
import 'package:waiwai_dictionary/components/appBar.dart';
import 'package:waiwai_dictionary/components/sidebarNotLogged.dart';

class WordPage extends StatelessWidget {
  const WordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: const MySideBar(),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Palavra: WAI WAI'),
            subtitle: Text(
                'Significado: Uma palavra que significa algo, mas que aqui é irrelevante.'),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Referência 1: http://www.exemplo.com'),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Referência 2: http://www.exemplo2.com'),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Significado Fonema: Exemplo de fonema.'),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text(
                'Comentário: Um comentário que explica a palavra e/ou seu significado.'),
          ),
        ],
      ),
    );
  }
}
