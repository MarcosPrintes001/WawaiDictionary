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
    String firstMeaning = meanings.isNotEmpty ? meanings.first.meaning : "";

    // Limitar o primeiro significado a 30 caracteres
    if (firstMeaning.length > 30) {
      firstMeaning = "${firstMeaning.substring(0, 30)}...";
    }

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
            Text(
              firstMeaning,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
