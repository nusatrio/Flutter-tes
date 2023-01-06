import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/ProgressHUD.dart';
import 'package:flutter_application_1/api/api_service.dart';
import 'package:flutter_application_1/model/login.dart';
import 'package:flutter_application_1/model/register.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final profileNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String? error;
  String? _password;
  bool _isVisible = true;
  bool passwordError = false;
  bool isApiCallProcess = false;
  bool usernameActive = false;
  bool passwordActive = false;
  bool profileNameActive = false;
  RegisterRequest? registerRequest;
  LoginRequest? loginRequest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerRequest = new RegisterRequest();
    loginRequest = new LoginRequest();
    usernameController.addListener(() {
      setState(() {
        usernameActive = usernameController.text.isNotEmpty;
      });
    });
    passwordController.addListener(() {
      setState(() {
        passwordActive = passwordController.text.isNotEmpty;
      });
    });
    profileNameController.addListener(() {
      setState(() {
        profileNameActive = profileNameController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    profileNameController.dispose();
  }

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
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      "Registrasi Akun",
                      style: TextStyle(fontSize: 35, color: Colors.blueAccent),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 24,
                    right: MediaQuery.of(context).size.width / 24,
                    top: 26,
                    bottom: 12),
                child: TextFormField(
                  //cek data field nya kosong
                  style: TextStyle(fontSize: 12, color: Color(0xff303030)),
                  keyboardType: TextInputType.text,
                  onSaved: (input) => registerRequest!.profileName = input,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tolong Masukkan nama profil Anda';
                    }
                    return null;
                  },
                  controller: profileNameController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 10),
                    hintText: 'Nama Profil Anda',
                    hintStyle:
                        TextStyle(color: Color(0xffc0c0c0), fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 24),
                    border: new OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffc0c0c0),
                        width: 1,
                      ),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffc0c0c0),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(5.0),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 24,
                    right: MediaQuery.of(context).size.width / 24,
                    top: 12,
                    bottom: 12),
                child: TextFormField(
                  //cek data field nya kosong
                  style: TextStyle(fontSize: 12, color: Color(0xff303030)),
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (input) => registerRequest!.username = input,
                  controller: usernameController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 10),
                    hintText: 'username Anda',
                    hintStyle:
                        TextStyle(color: Color(0xffc0c0c0), fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 24),
                    border: new OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffc0c0c0),
                        width: 1,
                      ),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffc0c0c0),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(5.0),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (String? value) {
                    if (value!.isNotEmpty &&
                        error == "USERNAME IS REGISTERED") {
                      return error;
                    } else {
                      passwordError = false;
                      return null;
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 24,
                    right: MediaQuery.of(context).size.width / 24,
                    top: 12,
                    bottom: 12),
                child: TextFormField(
                  //cek data field nya kosong
                  style: TextStyle(fontSize: 12, color: Color(0xff303030)),
                  obscureText: _isVisible,
                  keyboardType: TextInputType.text,
                  onSaved: (input) => registerRequest!.password = input,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },

                  controller: passwordController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 10),
                    hintText: 'Masukkan Password Anda',
                    hintStyle:
                        TextStyle(color: Color(0xffc0c0c0), fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 24),
                    border: new OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffc0c0c0),
                        width: 1,
                      ),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffc0c0c0),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(5.0),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: Icon(
                        _isVisible ? Icons.visibility : Icons.visibility_off,
                        color: passwordError == true
                            ? Color(0xffcc3333)
                            : Color(0xff0d579a),
                      ),
                      iconSize: 24,
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      top: 24.0, bottom: 5.0, left: 60.0, right: 60.0),
                  child: MaterialButton(
                    minWidth: 240.0,
                    height: 45.0,
                    color: Color(0xff0d579a),
                    textColor: Colors.white,
                    onPressed: () {
                      if (validateAndSave()) {}
                      setState(() {
                        isApiCallProcess = true;
                        error = null;
                        registerRequest!.username =
                            usernameController.value.text;
                        registerRequest!.profileName =
                            profileNameController.value.text;
                        registerRequest!.password =
                            passwordController.value.text;
                      });
                      RegisterAPIService apiService = new RegisterAPIService();
                      apiService.register(registerRequest!).then((value) async {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        if (value.message == "REGISTER SUCCESSFUL") {
                          print(value.toString());
                          Navigator.pop(context);
                        } else if (value.message == "USERNAME IS REGISTERED") {
                          setState(() {
                            error = value.message;
                          });
                        } else {
                          print(value.message);
                        }
                      });
                      print(registerRequest!.toJson());
                    },
                    child: Text(
                      "Daftar",
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  )),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Sudah punya akun? ',
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                    children: [
                      TextSpan(
                          text: 'Masuk',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) =>
                              //             PageLogin()));
                            },
                          style: const TextStyle(
                            color: Color(0xff0d579a),
                            decoration: TextDecoration.underline,
                          )),
                    ],
                  )),
            ],
          )),
    );
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
