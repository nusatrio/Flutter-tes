class TambahDataRequest {
  double? harga;
  int? id;
  String? namaBarang;
  int? stok;
  Supplier? supplier;

  TambahDataRequest(
      {this.harga, this.id, this.namaBarang, this.stok, this.supplier});

  factory TambahDataRequest.fromJson(Map<String, dynamic> json) =>
      TambahDataRequest(
        harga: json["harga"],
        id: json["id"],
        namaBarang: json["namaBarang"],
        stok: json["stok"],
        supplier: json["data"] != null
            ? Supplier.fromJson(json["supplier"])
            : json["supplier"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'harga': harga,
      'id': id,
      'namaBarang': namaBarang,
      'stok': stok,
      'supplier': supplier!.toJson(),
    };
    return map;
  }
}

class Supplier {
  int? id;
  String? namaSupplier;
  String? noTelp;
  String? alamat;

  Supplier({this.id, this.namaSupplier, this.noTelp, this.alamat});

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
      id: json["id"],
      namaSupplier: json["namaSupplier"],
      noTelp: json["noTelp"],
      alamat: json["alamat"]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'namaSupplier': namaSupplier,
      'noTelp': noTelp,
      'alamat': alamat,
    };
    return map;
  }
}

class TambahDataResponse {
  Data? data;
  String? message;
  String? status;

  TambahDataResponse({
    this.data,
    this.message,
    this.status,
  });

  factory TambahDataResponse.fromJson(Map<String, dynamic> json) =>
      TambahDataResponse(
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
  String? namaBarang;
  String? harga;
  String? stok;
  Supplier? supplier;

  Data({this.id, this.namaBarang, this.harga, this.stok, this.supplier});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] != null ? json["id"] : "",
        namaBarang: json["namaBarang"] != null ? json["namaBarang"] : "",
        harga: json["harga"] != null ? json["harga"] : "",
        stok: json["stok"] != null ? json["stok"] : "",
        supplier: json["supplier"] != null
            ? Supplier.fromJson(json["supplier"])
            : json["data"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'namaBarang': namaBarang,
      'harga': harga,
      'stok': stok,
      'supplier': supplier!.toJson(),
    };

    return map;
  }
}
