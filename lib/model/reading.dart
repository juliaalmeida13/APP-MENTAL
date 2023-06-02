class Reading {
  int? id;
  final String group;
  final String name;
  final String text;
  final int version;
  final String? idRelatedReading;

  Reading(
      {this.id,
      required this.group,
      required this.name,
      required this.text,
      required this.version,
      required this.idRelatedReading});

  factory Reading.fromMap(Map<String, dynamic> json) => new Reading(
        id: json['id'],
        group: json['group'],
        name: json['name'],
        text: json['text'],
        version: json['version'],
        idRelatedReading: json['idRelatedReading'],
      );

  factory Reading.fromJson(Map<String, dynamic> json) {
    return Reading(
        id: json['id'],
        group: json['group'],
        name: json['name'],
        text: json['text'],
        version: json['version'],
        idRelatedReading: json['idRelatedReading']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group': group,
      'name': name,
      'text': text,
      'version': version,
      'idRelatedReading': idRelatedReading
    };
  }
}
