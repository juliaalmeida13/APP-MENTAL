import 'dart:ffi';

class Reading {
  int? id;
  final String group;
  final String name;
  final String text;
  final int version;

  Reading(
      {this.id,
      required this.group,
      required this.name,
      required this.text,
      required this.version});

  factory Reading.fromMap(Map<String, dynamic> json) => new Reading(
      id: json['id'],
      group: json['group'],
      name: json['name'],
      text: json['text'],
      version: json['version']);

  factory Reading.fromJson(Map<String, dynamic> json) {
    return Reading(
        id: json['id'],
        group: json['group'],
        name: json['name'],
        text: json['text'],
        version: json['version']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group': group,
      'name': name,
      'text': text,
      'version': version
    };
  }
}
