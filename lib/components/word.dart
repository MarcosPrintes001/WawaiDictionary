import 'package:flutter/material.dart';

class WordComponent extends StatelessWidget {
  final VoidCallback onTap;

  const WordComponent({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String significado = "Significado 1, Significado 2";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(left: 10.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Palavra',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Text(
              _getShortenedMeaning('${significado}'),
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
