import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/api_service.dart';
import 'package:flutter_application_1/model/list_barang.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ListBarang extends StatefulWidget {
  @override
  _ListBarangState createState() => _ListBarangState();
}

class _ListBarangState extends State<ListBarang> {
  int offset = 1;
  String? token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getListBarang();
  }

  Future<List<dynamic>> listBarang() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("token");
    });
    final response = await http.get(
        Uri.parse(
            "http://159.223.57.121:8090/barang/find-all?limit=20&offset=$offset"),
        headers: {
          "Authorization": 'Bearer $token',
          "content-type": "application/json",
        });
    return json.decode(response.body)["data"];
  }

  deleteBarang(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("token");
    });
    final response = await http.delete(
        Uri.parse("http://159.223.57.121:8090/barang/delete/$id"),
        headers: {
          "Authorization": 'Bearer $token',
          "content-type": "application/json",
        });
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Barang"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextButton(
                onPressed: () {}, child: Text("+ Tambah Data Barang")),
          ),
          FutureBuilder<List<dynamic>>(
              future: listBarang(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("No. " + (index + 1).toString()),
                              Text("Nama Barang: " +
                                  snapshot.data[index]["namaBarang"]),
                              Text("Harga: " +
                                  snapshot.data[index]["harga"].toString()),
                              Text("Stok: " +
                                  snapshot.data[index]["stok"].toString()),
                              Text("Nama Supplier: " +
                                  snapshot.data[index]["supplier"]
                                      ["namaSupplier"]),
                              Text("No. Telp: " +
                                  snapshot.data[index]["supplier"]["noTelp"]),
                              Text("Alamat: " +
                                  snapshot.data[index]["supplier"]["alamat"]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text("Update"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteBarang(snapshot.data[index]["id"]);
                                      final snackBar = SnackBar(
                                          content: const Text(
                                              'Data berhasil dihapus'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Divider(
                                    height: 2,
                                    thickness: 2,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      )),
    );
  }
}
