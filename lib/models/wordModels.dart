// ignore_for_file: file_names

class Word {
  final int id;
  final String word;
  final String phonemic;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;

  Word({
    required this.id,
    required this.word,
    required this.phonemic,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'],
      word: json['word'],
      phonemic: json['phonemic'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['update_at']),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'phonemic': phonemic,
      'created_at': createdAt.toIso8601String(),
      'update_at': updatedAt.toIso8601String(),
      'user_id': userId,
    };
  }
}

class Reference {
  final int id;
  final String reference;
  final String url;

  Reference({
    required this.id,
    required this.reference,
    required this.url,
  });

  factory Reference.fromJson(Map<String, dynamic> json) {
    return Reference(
      id: json['id'],
      reference: json['reference'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reference': reference,
      'url': url,
    };
  }
}

class Meaning {
  final int id;
  final String meaning;
  final String comment;
  final int wordId;
  final int referenceId;
  final int userId;

  Meaning({
    required this.id,
    required this.meaning,
    required this.comment,
    required this.wordId,
    required this.referenceId,
    required this.userId,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      id: json['id'],
      meaning: json['meaning'],
      comment: json['comment'],
      wordId: json['word_id'],
      referenceId: json['reference_id'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meaning': meaning,
      'comment': comment,
      'word_id': wordId,
      'reference_id': referenceId,
      'user_id': userId,
    };
  }
}
