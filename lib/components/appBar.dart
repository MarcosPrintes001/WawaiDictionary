import 'package:flutter/material.dart';

MyAppBar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.grey[200],
    title: const Image(
      image: AssetImage("assets/dicName.png"),
      height: 120,
      width: 120,
    ),
  );
}
