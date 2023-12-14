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
      ),
      body: SafeArea(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: _wordDisplay.length + 1,
            itemBuilder: (context, index) {
              _wordDisplay;
              return null;
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
