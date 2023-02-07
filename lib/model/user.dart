class UserApp {
  String userId;
  String? email = "";
  String? name = "";
  String? imageUrl = "";

  UserApp({required this.userId, this.email, this.name, this.imageUrl});

  factory UserApp.fromJson(Map<String, dynamic> json) {
    return UserApp(
        userId: json['id'],
        email: json['email'],
        name: json['name'],
        imageUrl: json['imageUrl']);
  }
}
