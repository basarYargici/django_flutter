// To parse this JSON data, do
//
//     final translate = translateFromJson(jsonString);

import 'dart:convert';

import 'package:local_host_workspace/model/%C4%B1_model.dart';

List<Translate> translateFromJson(String str) => List<Translate>.from(json.decode(str).map((x) => Translate.fromJson(x)));

String translateToJson(List<Translate> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Translate with IModel {
  Translate({
    this.id,
    this.english,
    this.turkish,
  });

  int id;
  String english;
  String turkish;

  factory Translate.fromJson(Map<String, dynamic> json) => Translate(
        id: json['id'],
        english: json['english'],
        turkish: json['turkish'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'english': english,
        'turkish': turkish,
      };

  @override
  List<Translate> fromJson(String str) => List<Translate>.from(json.decode(str).map((x) => Translate.fromJson(x))).toList();
}
