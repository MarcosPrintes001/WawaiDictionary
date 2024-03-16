// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

MyExpansionTile(
    String Significado, String Fonema, String Comentario, String Referencia) {
  String getShortenedWord(String meaning) {
    if (meaning.length <= 30) {
      return meaning;
    } else {
      return '${meaning.substring(0, 30)}...';
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Theme(
        data: ThemeData(
          dividerColor:
              Colors.transparent, // Define a cor do divisor como transparente
        ),
        child: ExpansionTile(
          title: Text(
            getShortenedWord(
                Referencia), // TODO: Ajustar texto no card. Comparar com Figma para fidelizar o design
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
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
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Significado:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: Significado),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        RichText(
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
                                text:
                                    Fonema.isNotEmpty ? Fonema : 'Indisponível',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        RichText(
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
                                text: Comentario.isNotEmpty
                                    ? Comentario
                                    : 'Indisponível',
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
    ],
  );
}
