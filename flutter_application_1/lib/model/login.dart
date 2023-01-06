class LoginRequest {
  String? username;
  String? password;

  LoginRequest({
    this.password,
    this.username
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      LoginRequest(username: json["username"],
      password: json["password"]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username,
      'password': password,
    };
    return map;
  }
}

class LoginResponse {
  Data? data;
  String? message;
  String? status;

  LoginResponse({
    this.data,
    this.message,
    this.status,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(
        status: json["status"] != null ? json["status"] : "",
        data: json["data"] != null ?Data.fromJson(json["data"]):json["data"],
        message: json["message"] != null ? json["message"] : "",
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'status': status,
      'data': data!.toJson(),
      'message': message
    };

    return map;
  }
}

class Data {
  int? id;
  String? username;
  String? profileName;
  String? token;

  Data({
    this.id,
    this.username,
    this.profileName,
    this.token
  });

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
        id: json["id"] != null ? json["id"] : "",
        username: json["username"] != null ? json["username"] : "",
        profileName: json["profileName"] != null ? json["profileName"] : "",
        token: json["token"] != null ? json["token"] : "",
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'username': username,
      'profileName': profileName,
      'token': token
    };

    return map;
  }
}
