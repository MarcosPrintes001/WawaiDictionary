import 'package:flutter/material.dart';
import 'package:waiwai_dictionary/models/wordModels.dart';

class WordComponent extends StatelessWidget {
  final VoidCallback onTap;
  final Word word;
  final List<Meaning> meanings;

  const WordComponent({
    Key? key,
    required this.onTap,
    required this.word,
    required this.meanings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              word.word,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 10),
            //TODO: não colocar em colunas e sim em linhas
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: meanings.map((meaning) {
                return Text(
                  _getShortenedMeaning(meaning.meaning),
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  String _getShortenedMeaning(String meaning) {
    if (meaning.length <= 20) {
      return meaning;
    } else {
      return '${meaning.substring(0, 20)}...';
    }
  }
}
