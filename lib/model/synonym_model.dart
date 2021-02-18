// To parse this JSON data, do
//
//     final synonym = synonymFromJson(jsonString);

import 'dart:convert';

List<Synonym> synonymFromJson(String str) => List<Synonym>.from(json.decode(str).map((x) => Synonym.fromJson(x)));

String synonymToJson(List<Synonym> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Synonym {
  Synonym({
    this.word,
    this.synonym,
    this.description,
  });

  String word;
  String synonym;
  String description;

  factory Synonym.fromJson(Map<String, dynamic> json) => Synonym(
    word: json["word"],
    synonym: json["synonym"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "word": word,
    "synonym": synonym,
    "description": description,
  };
}
