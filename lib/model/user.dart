class UserApp {
  String? email = "";
  String? name = "";
  String? imageUrl = "";

  UserApp({this.email, this.name, this.imageUrl});

  factory UserApp.fromJson(Map<String, dynamic> json) {
    return UserApp(
        email: json['email'], name: json['name'], imageUrl: json['imageUrl']);
  }
}
