import 'package:flutter/material.dart';

import 'package:waiwai_dictionary/models/wordModels.dart';

class DictHomePage extends StatefulWidget {
  const DictHomePage({super.key});

  @override
  State<DictHomePage> createState() => _DictHomePageState();
}

class _DictHomePageState extends State<DictHomePage> {
  //final List<wordModel> _words = <wordModel>[];
  final List<wordModel> _wordDisplay = <wordModel>[];
  final _scrollController = ScrollController();

  //bool _isLoading = true;
  final _searchWordController = TextEditingController();


  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(166, 51, 41, 1),
        elevation: 0.0,
        title: const Text("Dicionario", textAlign: TextAlign.left),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Adicione a lógica para exibir o popup
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Filtro'),
                    // Adicione o conteúdo do popup aqui
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          // Adicione os itens do filtro aqui
                          TextFormField(
                            controller: _searchWordController,
                            decoration: const InputDecoration(
                                label: Text('Palavra'),
                                hintText: 'Aparaca',
                                filled: true,
                                fillColor: Colors.white,
                                errorStyle: TextStyle(color: Colors.orange)),
                          ),
                          Autocomplete(optionsBuilder:
                              (TextEditingValue textEditingValue) {
                            return [
                              'Option 1',
                              'Option 2',
                              'Option 3',
                              'Option 4'
                            ]
                                .where((String option) => option.contains(
                                    textEditingValue.text.toLowerCase()))
                                .toList();
                          }, onSelected: (String value) {
                            setState(() {
                            });
                          }, fieldViewBuilder: (BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted) {
                            return TextField(
                              controller: textEditingController,
                              focusNode: focusNode,
                              decoration: const InputDecoration(
                                labelText: 'Choose an option',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {
                                // Opções são atualizadas automaticamente conforme o usuário digita
                                // Faça aqui qualquer processamento adicional desejado
                              },
                            );
                          }, optionsViewBuilder: (BuildContext context,
                              AutocompleteOnSelected<String> onSelected,
                              Iterable<String> options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                elevation: 4.0,
                                child: Container(
                                  constraints: const BoxConstraints(maxHeight: 200),
                                  child: ListView.builder(
                                    itemCount: options.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final String option =
                                          options.elementAt(index);
                                      return ListTile(
                                        title: Text(option),
                                        onTap: () {
                                          onSelected(option);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          })
                          // ...
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Fechar o popup
                            },
                            child: const Text('Filtrar'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Fechar o popup
                            },
                            child: const Text('Fechar'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              color: Colors.white,
              Icons.search_rounded,
            ),
            label: const Text(
              "filtro",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: _wordDisplay.length + 1,
            itemBuilder: (context, index) {
              _wordDisplay;
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(166, 51, 41, 1),
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
//   _searchBar() {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: TextField(
//         style: GoogleFonts.openSans(
//           color: Colors.black,
//         ),
//         autofocus: false,
//         onChanged: (searchText) {
//           searchText = searchText.toLowerCase();
//           setState(() {
//             _wordDisplay = _words.where((u) {
//               var ptWord = u.meaningPort.toLowerCase();
//               var waiWord = u.meaningWaiwai.toLowerCase();
//               return ptWord.contains(searchText) ||
//                   waiWord.contains(searchText);
//             }).toList();
//           });
//         },
//         decoration: const InputDecoration(
//           border: OutlineInputBorder(),
//           prefixIcon: Icon(Icons.search),
//           hintText: 'Buscar Palavras',
//         ),
//       ),
//     );
//   }
// }
