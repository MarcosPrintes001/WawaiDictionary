import 'package:flutter/material.dart';

@immutable
class User {
  static const tableName = 'User';
  static const idColumn = 'id';
  static const fullnameColumn = 'full_name';

  final int id;
  final String fullname;

  const User({required this.id, required this.fullname});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id;
  }

  @override
  int get hashCode => id;
}
