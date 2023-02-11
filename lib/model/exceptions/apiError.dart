class ApiError {
  String? message = "";
  String? httpStatus = "";

  ApiError({this.message, this.httpStatus});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(message: json['message'], httpStatus: json['httpStatus']);
  }
}
