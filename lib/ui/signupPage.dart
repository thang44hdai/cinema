import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

double heightScreen = 0;
double widthScreen = 0;
TextEditingController _tk_registerController = TextEditingController();
TextEditingController _mk_registerController = TextEditingController();
TextEditingController _verifyPassWordController = TextEditingController();
TextEditingController _nameUserController = TextEditingController();

void add_user(String acc, String name, String pw, List<String> ticket) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = <String, dynamic>{
    "account": acc,
    "name": name,
    "password": pw,
    "ticket": ticket,
  };
  firestore.collection("users").doc(acc + pw).set(user);
}

class signupPage extends StatelessWidget {
  const signupPage({super.key});

  @override
  Widget build(BuildContext context) {
    heightScreen = MediaQuery.of(context).size.height;
    widthScreen = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg_login.png'),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Color.fromRGBO(1, 81, 152, 1).withOpacity(0.5),
              BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: Container(
                  color: Colors.white,
                  height: 550,
                  width: widthScreen,
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Image.asset('assets/welcome.png'),
                                height: 100,
                              ),
                            ),
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  color: Color.fromRGBO(1, 81, 152, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32),
                            ),
                            Text(
                              "Please fill in your information",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: _tk_registerController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "Email:",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  )),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextField(
                              controller: _nameUserController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "Họ và tên:",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  )),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextField(
                              obscureText: true,
                              controller: _mk_registerController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "Mật khẩu:",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  )),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextField(
                              obscureText: true,
                              controller: _verifyPassWordController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "Nhập lại mật khẩu:",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  )),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final auth = FirebaseAuth.instance;
                                auth.createUserWithEmailAndPassword(
                                    email: _tk_registerController.text,
                                    password: _mk_registerController.text);
                                Navigator.pop(context);
                                add_user(
                                    _tk_registerController.text,
                                    _nameUserController.text,
                                    _mk_registerController.text, []);
                                _tk_registerController.text =
                                    _mk_registerController.text = "";
                                // Hiển thị thông báo đăng kí thành công
                                final snackBar = SnackBar(
                                  content: Text('Đăng kí thành công!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                // Đóng thông báo sau 2 giây
                                Timer(
                                  Duration(seconds: 2),
                                  () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: Color.fromRGBO(1, 81, 152, 1),
                                elevation: 20,
                                shadowColor: Color.fromRGBO(1, 81, 152, 1),
                                minimumSize: Size.fromHeight(60),
                              ),
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
