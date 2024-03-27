class Word {
  final int id;
  final String word;
  final String? phonemic;
  final String createdAt;
  final String updatedAt;
  final int userId;

  Word({
    required this.id,
    required this.word,
    this.phonemic,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'] ?? 0,
      word: json['word'] ?? '',
      phonemic: json['phonemic'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['update_at'] ?? '',
      userId: json['user_id'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'phonemic': phonemic,
      'created_at': createdAt,
      'update_at': updatedAt,
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
      id: json['id'] ?? 0,
      reference: json['reference'] ?? '',
      url: json['url'] ?? '',
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

// "version": 1.1,
// "words": "2024-03-19T22:27:56.330858",
// "meanings": "2024-03-19T22:27:56.330858",
// "categories": "2024-03-19T22:27:56.330858",
// "references": "2024-03-19T22:27:56.330858",
// "attachments": "2024-03-19T22:27:56.330858",
// "users": "2024-03-19T22:27:56.330858"

class Version {
  final bool version;
  final String words;
  final String meanings;
  final String categories;
  final String references;
  final String attachments;
  final String users;

  Version({
    required this.version,
    required this.words,
    required this.meanings,
    required this.categories,
    required this.references,
    required this.attachments,
    required this.users,
  });
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
      id: json['id'] ?? 0,
      meaning: json['meaning'] ?? '',
      comment: json['comment'] ?? '',
      wordId: json['word_id'] ?? 0,
      referenceId: json['reference_id'] ?? 0,
      userId: json['user_id'] ?? 0,
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
