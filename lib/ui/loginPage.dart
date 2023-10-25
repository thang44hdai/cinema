import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/constants.dart';
import '../models/user.dart';
import 'homePage.dart';

double heightScreen = 0;
double widthScreen = 0;
TextEditingController _tk_loginController = TextEditingController();
TextEditingController _mk_loginController = TextEditingController();

void signIn(BuildContext context, String tk, String mk) async {
  try {
    final auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: tk,
      password: mk,
    );
    //user a = user(name: "name", account: "account", password: "password", ticket: []);
    user a = await read_user(tk + mk);
    Constants.User = a;
    // Đăng nhập thành công, chuyển hướng sang màn hình khác
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => homePage(
          User: a,
        ),
      ),
    );
  } catch (e) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Future<user> read_user(String docs) async {
  DocumentSnapshot documentSnapshot =
      await FirebaseFirestore.instance.collection("users").doc(docs).get();

  if (documentSnapshot.exists) {
    var account = documentSnapshot.get("account");
    var name = documentSnapshot.get("name");
    var pw = documentSnapshot.get("password");
    var _ticket = documentSnapshot.get("ticket") as List<dynamic>;
    var ticket = _ticket.cast<String>().toList();

    return user(name: name, account: account, password: pw, ticket: ticket);
  } else {
    print("Error");
    return user(name: "", account: "", password: "", ticket: []);
  }
}

class loginPage extends StatelessWidget {
  const loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    heightScreen = MediaQuery.of(context).size.height;
    widthScreen = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/seat.jpg'),
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
                  height: 600,
                  width: widthScreen,
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
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
                          "Please log in your information",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _tk_loginController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: "Email:",
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          obscureText: true,
                          controller: _mk_loginController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: "Mật khẩu: ",
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            signIn(context, _tk_loginController.text,
                                _mk_loginController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: Color.fromRGBO(1, 81, 152, 1),
                            elevation: 20,
                            shadowColor: Color.fromRGBO(1, 81, 152, 1),
                            minimumSize: Size.fromHeight(60),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
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
