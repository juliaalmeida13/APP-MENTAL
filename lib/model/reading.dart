import 'dart:ffi';

class Reading {
  int? id;
  final String group;
  final String name;
  final String text;
  final String type;
  final String image;
  final String? video;
  final int version;

  Reading(
      {this.id,
      required this.group,
      required this.name,
      required this.text,
      required this.type,
      required this.image,
      required this.video,
      required this.version});

  factory Reading.fromMap(Map<String, dynamic> json) => new Reading(
      id: json['id'],
      group: json['group'],
      name: json['name'],
      text: json['text'],
      type: json['type'],
      image: json['image'],
      video: json['video'],
      version: json['version']);

  factory Reading.fromJson(Map<String, dynamic> json) {
    return Reading(
        id: json['id'],
        group: json['group'],
        name: json['name'],
        text: json['text'],
        type: json['type'],
        image: json['image'],
        video: json['video'],
        version: json['version']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group': group,
      'name': name,
      'text': text,
      'type': type,
      'image': image,
      'video': video,
      'version': version
    };
  }
}
