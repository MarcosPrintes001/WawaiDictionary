// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:waiwai_dictionary/models/wordModels.dart';

class MyExpantionTile extends StatefulWidget {
  final String significado;
  final String fonema;
  final Meaning meaning;

  const MyExpantionTile({
    Key? key,
    required this.significado,
    required this.fonema,
    required this.meaning,
  }) : super(key: key);

  @override
  State<MyExpantionTile> createState() => _MyExpantionTileState();
}

class _MyExpantionTileState extends State<MyExpantionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Text(
            '${widget.meaning.referenceId}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Siginificado: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: widget.meaning.meaning == 'null' ||
                                        widget.meaning.meaning.isEmpty
                                    ? 'Indisponível'
                                    : widget.meaning.meaning,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 0), // Ajuste aqui
                          child: RichText(
                            textAlign: TextAlign.left,
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
                                  text: widget.fonema == 'null' ||
                                          widget.fonema.isEmpty
                                      ? 'Indisponível'
                                      : widget.fonema,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 0), // Ajuste aqui
                          child: RichText(
                            textAlign: TextAlign.left,
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
                                  text: widget.meaning.comment.isEmpty ||
                                          widget.meaning.comment == 'null'
                                      ? 'Indisponível'
                                      : widget.meaning.comment,
                                ),
                              ],
                            ),
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
