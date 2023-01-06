class RegisterRequest {
  String? username;
  String? password;
  String? profileName;

  RegisterRequest({this.password, this.username, this.profileName});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        username: json["username"], 
        profileName: json["profileName"], 
        password: json["password"]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username,
      'password': password,
      'profileName': profileName,
    };
    return map;
  }
}

class RegisterResponse {
  Data? data;
  String? message;
  String? status;

  RegisterResponse({
    this.data,
    this.message,
    this.status,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
        status: json["status"] != null ? json["status"] : "",
        data: json["data"] != null ? Data.fromJson(json["data"]) : json["data"],
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

  Data({this.id, this.username, this.profileName});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] != null ? json["id"] : "",
        username: json["username"] != null ? json["username"] : "",
        profileName: json["profileName"] != null ? json["profileName"] : "",
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'username': username,
      'profileName': profileName,
    };

    return map;
  }
}
