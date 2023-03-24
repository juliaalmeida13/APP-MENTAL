class Contact {
  final int id;
  final String name;
  final String number;

  Contact({
    required this.id,
    required this.name,
    required this.number,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(id: json['id'], name: json['name'], number: json['number']);
  }
}
