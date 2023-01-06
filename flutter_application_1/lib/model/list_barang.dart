class ListBarangResponse {
  // Data? data;
  String? message;
  String? status;
  String? limit;
  String? page;
  String? totalPage;
  String? totalRecord;

  ListBarangResponse({
    // this.data,
    this.message,
    this.status,
    this.limit,
    this.page,
    this.totalPage,
    this.totalRecord,
  });

  factory ListBarangResponse.fromJson(Map<String, dynamic> json) =>
      ListBarangResponse(
        status: json["status"] != null ? json["status"] : "",
        // data: json["data"] != null ?Data.fromJson(json["data"]):json["data"],
        message: json["message"] != null ? json["message"] : "",
        limit: json["limit"] != null ? json["limit"] : "",
        page: json["page"] != null ? json["page"] : "",
        totalPage: json["totalPage"] != null ? json["totalPage"] : "",
        totalRecord: json["totalRecord"] != null ? json["totalRecord"] : "",
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'status': status,
      // 'data': data!.toJson(),
      'message': message,
      'limit': limit,
      'page': page,
      'totalPage': totalPage,
      'totalRecord': totalRecord
    };

    return map;
  }
}

// class Data {
//   int? id;
//   String? username;
//   String? profileName;
//   String? token;

//   Data({
//     this.id,
//     this.username,
//     this.profileName,
//     this.token
//   });

//   factory Data.fromJson(Map<String, dynamic> json) =>
//       Data(
//         id: json["id"] != null ? json["id"] : "",
//         username: json["username"] != null ? json["username"] : "",
//         profileName: json["profileName"] != null ? json["profileName"] : "",
//         token: json["token"] != null ? json["token"] : "",
//       );

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> map = {
//       'id': id,
//       'username': username,
//       'profileName': profileName,
//       'token': token
//     };

//     return map;
//   }
// }
