import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
MyAppBar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: const Color(0xFFF2F2F2),
    title: const Image(
      image: AssetImage("assets/dicName.png"),
      height: 120,
      width: 120,
    ),
  );
}
