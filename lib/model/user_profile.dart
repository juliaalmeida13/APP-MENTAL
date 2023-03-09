class UserProfile {
  int? id;
  String? gender;
  String? age;
  String? workplace;
  String? maritalStatus;
  String? occupation;
  String? phone;

  UserProfile(
      {this.id,
      this.gender,
      this.age,
      this.workplace,
      this.maritalStatus,
      this.occupation,
      this.phone});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        id: json['id'],
        gender: json['gender'],
        age: json['age'],
        workplace: json['workplace'],
        maritalStatus: json['maritalStatus'],
        occupation: json['occupation'],
        phone: json['phone']);
  }
}
