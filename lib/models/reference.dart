import 'package:flutter/material.dart';

@immutable
class Reference {
  static const tableName = 'Reference';
  static const idColumn = 'id';
  static const referenceColumn = 'reference';
  static const urlColumn = 'url';

  final int id;
  final String reference;
  final String url;

  const Reference({required this.id, required this.reference, String? url})
      : url = url ?? '';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reference && other.id == id;
  }

  @override
  int get hashCode => id;
}
