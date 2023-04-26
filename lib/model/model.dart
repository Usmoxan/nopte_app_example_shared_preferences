import 'package:flutter/material.dart';

class Notes {
  String? dateTimeNow;
  String? title;
  String? content;
  String? color;
  DateTime? createdAt;

  Notes({this.content, this.createdAt, this.title, this.color, required dateTimeNow});

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      dateTimeNow: json['dateTimeNow'],
      title: json['title'],
      content: json['content'],
      color: json['color'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTimeNow': dateTimeNow,
      'title': title,
      'content': content,
      'color': color,
      'createdAt': createdAt!.toIso8601String(),
    };
  }
}
