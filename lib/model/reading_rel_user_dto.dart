class ReadingRelUserDTO {
  String? group;
  String? name;

  ReadingRelUserDTO({this.group, this.name});

  factory ReadingRelUserDTO.fromJson(Map<String, dynamic> json) {
    return ReadingRelUserDTO(group: json['group'], name: json['name']);
  }
}
