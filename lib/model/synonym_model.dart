// To parse this JSON data, do
//
//     final synonym = synonymFromJson(jsonString);

import 'dart:convert';

import 'package:local_host_workspace/model/%C4%B1_model.dart';

List<Synonym> synonymFromJson(String str) => List<Synonym>.from(json.decode(str).map((x) => Synonym.fromJson(x)));

String synonymToJson(List<Synonym> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Synonym with IModel {
  Synonym({
    this.word,
    this.synonym,
    this.description,
    this.id,
  });

  String word;
  String synonym;
  String description;
  int id;

  factory Synonym.fromJson(Map<String, dynamic> json) => Synonym(
        word: json['word'],
        synonym: json['synonym'],
        description: json['description'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'word': word,
        'synonym': synonym,
        'description': description,
        'id': id,
      };

  @override
  List<Synonym> fromJson(String str) => List<Synonym>.from(json.decode(str).map((x) => Synonym.fromJson(x))).toList();
}
