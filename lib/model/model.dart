class Notes {
  String? content;
  DateTime? createdAt;

  Notes({this.content, this.createdAt});

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'createdAt': createdAt!.toIso8601String(),
    };
  }
}