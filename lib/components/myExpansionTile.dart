// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:waiwai_dictionary/models/wordModels.dart';

class MyExpantionTile extends StatefulWidget {
  final String referencia;
  final String significado;
  final String fonema;
  final String comentario;
  final List<Meaning> Meanings;

  const MyExpantionTile(
      {super.key,
      required this.referencia,
      required this.significado,
      required this.fonema,
      required this.comentario,
      required this.Meanings});

  @override
  State<MyExpantionTile> createState() => _MyExpantionTileState();
}

class _MyExpantionTileState extends State<MyExpantionTile> {
  String getShortenedWord(String meaning) {
    if (meaning.length <= 30) {
      return meaning;
    } else {
      return '${meaning.substring(0, 30)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Theme(
              data: ThemeData(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile( 
                title: Text(
                  widget .referencia, // TODO: Ajustar texto no card. Comparar com Figma para fidelizar o design
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Fonema: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.fonema.isEmpty
                                            ? 'Indisponível'
                                            : widget.fonema,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Comentário: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.comentario.isNotEmpty
                                            ? widget.comentario
                                            : 'Indisponível',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.Meanings.length,
                                itemBuilder: (context, index) {
                                  final meaning = widget.Meanings[index];
                                  return ListTile(
                                    title: Text(meaning.meaning),
                                    subtitle: Text(meaning.comment),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
