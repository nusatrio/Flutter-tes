import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ProgressHUD.dart';
import 'package:flutter_application_1/api/api_service.dart';
import 'package:flutter_application_1/model/login.dart';
import 'package:flutter_application_1/pages/list_barang_page.dart';
import 'package:flutter_application_1/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController myUsernameController = TextEditingController();
  final TextEditingController myPasswordController = TextEditingController();
  bool _isObscure = true;
  LoginRequest? loginRequest;
  bool isApiCallProcess = false;
  bool passwordError = false;
  String? error;
  String? email;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    loginRequest = new LoginRequest();
  }

  @override
  void dispose() {
    myUsernameController.dispose();
    myPasswordController.dispose();
    super.dispose();
  }

  // Future _cekLogin() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   if (pref.getBool("isLogin")!) {
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      /*appBar: AppBar(
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        title: Image(
                height: 24.0,
                image: AssetImage(
                  'assets/img/Logo_4x.png',
                )
              ),
        backgroundColor: Colors.white,
      ),*/
      body: Center(
        child: Form(
            key: _formKey,
            child: ListView(shrinkWrap: true, children: [
              new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Container(
                  //     margin: EdgeInsets.only(
                  //         top: MediaQuery.of(context).size.width / 4.5,
                  //         left: 20,
                  //         right: 20),
                  //     child: Image(
                  //         height: 44.4,
                  //         image: AssetImage(
                  //           'assets/img/Logo_4x.png',
                  //         ))),
                  Container(
                      margin: EdgeInsets.only(top: 16, left: 20, right: 20),
                      child: Text(
                        "Welcome!",
                        style:
                            TextStyle(fontSize: 40, color: Colors.blueAccent),
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 24,
                        right: MediaQuery.of(context).size.width / 24,
                        top: 64,
                        bottom: 0),
                    child: TextFormField(
                      //cek data field nya kosong
                      keyboardType: TextInputType.name,
                      onSaved: (input) => loginRequest!.username = input,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Wajib diisi';
                        } else if (value.isNotEmpty &&
                            error == "LOGIN FAILED") {
                          return 'Username atau Password salah';
                        }
                        return null;
                      },
                      controller: myUsernameController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan Username Anda',
                        contentPadding: EdgeInsets.only(
                            left: 24, right: 24, top: 16, bottom: 16),
                        border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                            borderSide: const BorderSide(
                                color: const Color(0xffc0c0c0), width: 1.0)),
                        filled: true,
                        hintStyle: new TextStyle(color: Color(0xffc0c0c0)),
                        fillColor: Colors.white,
                        errorStyle: TextStyle(
                          color: Colors.red[700],
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 24,
                        right: MediaQuery.of(context).size.width / 24,
                        top: 40,
                        bottom: 0),
                    child: TextFormField(
                      //cek data field nya kosong
                      keyboardType: TextInputType.text,
                      onSaved: (String? value) =>
                          loginRequest!.password = value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          passwordError = true;
                          return 'Wajib diisi';
                        } else if (value.isNotEmpty &&
                            error == "LOGIN FAILED") {
                          passwordError = true;
                          return 'Username atau Password salah';
                        } else {
                          passwordError = false;
                          return null;
                        }
                      },
                      obscureText: _isObscure,
                      controller: myPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan Password Anda',
                        contentPadding: EdgeInsets.only(
                            left: 24, right: 24, top: 16, bottom: 16),
                        border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                            borderSide: const BorderSide(
                                color: const Color(0xffc0c0c0), width: 1.0)),
                        filled: true,
                        hintStyle: new TextStyle(color: Color(0xffc0c0c0)),
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: passwordError == true
                                ? Colors.red[700]
                                : Color(0xff0d579a),
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red[700],
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    /*margin: EdgeInsets.only(
                  top: 56,
                  left: 60,
                  right: 60
                ), */
                    margin: const EdgeInsets.only(
                        top: 24.0, bottom: 5.0, left: 40.0, right: 40.0),
                    // width: MediaQuery.of(context).size.width / 1.09,
                    width: 240.0,
                    height: 45.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                        setState(() {
                          isApiCallProcess = true;
                          loginRequest!.username =
                              myUsernameController.value.text;
                          loginRequest!.password =
                              myPasswordController.value.text;
                        });

                        LoginAPIService apiService = new LoginAPIService();
                        apiService.login(loginRequest!).then((value) async {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          print(value.message);
                          if (value.message == "LOGIN SUCCESS") {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.setBool("isLogin", true);
                            // pref.setString("id", value.data!.id.toString());
                            pref.setString(
                                "token", value.data!.token.toString());
                            goToHomePage();
                            print(value.data!.token);
                          } else {
                            print("test");
                            setState(() {
                              error = value.message;
                            });
                          }
                        }).catchError((err) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        });
                        print(loginRequest!.toJson());
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff0d579a)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ))),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 40.0, right: 40.0),
                    width: 240.0,
                    height: 45.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => SignUpPage()));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xffffffff)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ))),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15.0,
                          color: Color(0xff0d579a),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ])),
      ),
    );
  }

  goToHomePage() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ListBarang(),
        ));
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
