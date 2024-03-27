import 'package:flutter/material.dart';

@immutable
class Word {
  static const tableName = 'Word';
  static const idColumn = 'id';
  static const wordColumn = 'word';
  static const phonemicColumn = 'phonemic';
  static const createdAtColumn = 'created_at';
  static const updateAtColumn = 'update_at';
  static const userIdColumn = 'user_id';

  final int id;
  final String word;
  final String phonemic;
  final String createdAt;
  final String updateAt;
  final int userId;

  const Word(
      {required this.id,
      required this.word,
      String? phonemic,
      required this.createdAt,
      required this.updateAt,
      required this.userId})
      : phonemic = phonemic ?? '';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Word && other.id == id;
  }

  @override
  int get hashCode => id;
}
