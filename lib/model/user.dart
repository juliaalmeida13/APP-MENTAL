class UserApp {
  String? email = "";
  String? name = "";
  String? imageUrl = "";
  String? gender;
  String? age;
  String? workplace;
  String? maritalStatus;
  String? occupation;
  String? phone;

  UserApp(
      {this.email,
      this.name,
      this.imageUrl,
      this.gender,
      this.age,
      this.workplace,
      this.maritalStatus,
      this.occupation,
      this.phone});

  factory UserApp.fromJson(Map<String, dynamic> json) {
    return UserApp(
        email: json['email'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        gender: json['gender'],
        age: json['age'],
        workplace: json['workplace'],
        maritalStatus: json['maritalStatus'],
        occupation: json['occupation'],
        phone: json['phone']);
  }
}
