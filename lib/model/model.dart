import 'package:flutter/material.dart';

class Notes {
  String? title;
  String? content;
  String? color;
  DateTime? createdAt;

  Notes({this.content, this.createdAt, this.title, this.color});

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      title: json['title'],
      content: json['content'],
      color: json['color'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'color': color,
      'createdAt': createdAt!.toIso8601String(),
    };
  }
}
