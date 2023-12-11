import 'package:flutter/material.dart';
import 'package:waiwai_dictionary/screens/home.dart';
import 'package:waiwai_dictionary/screens/login.dart';

//Função principal Flutter
void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }

}