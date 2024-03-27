import 'package:flutter/material.dart';

@immutable
class Meaning {
  static const tableName = 'Meaning';
  static const idColumn = 'id';
  static const meaningColumn = 'meaning';
  static const commentColumn = 'comment';
  static const chapterIdColumn = 'chapter_id';
  static const entryIdColumn = 'entry_id';
  static const wordIdColumn = 'word_id';
  static const referenceIdColumn = 'reference_id';
  static const userIdColumn = 'user_id';

  final int id;
  final String meaning;
  final String comment;
  final int chapterId;
  final int entryId;
  final int wordId;
  final int referenceId;
  final int userId;

  const Meaning(
      {required this.id,
      required this.meaning,
      required this.comment,
      required this.chapterId,
      required this.entryId,
      required this.wordId,
      required this.referenceId,
      required this.userId});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Meaning && other.id == id;
  }

  @override
  int get hashCode => id;
}
