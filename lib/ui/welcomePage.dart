import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';

import 'homePage.dart';

TextEditingController _tkController = TextEditingController();
TextEditingController _mkController = TextEditingController();
TextEditingController _verifyPassWord = TextEditingController();
TextEditingController _nameUser = TextEditingController();

class welcomePage extends StatelessWidget {
  const welcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Container(
              //color: Colors.brown,
              height: screenHeight / 3.5,
              child: Image(
                image: NetworkImage(
                    "https://channel.mediacdn.vn/428462621602512896/2023/7/5/photo-2-1688527936105123487460.jpg"),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                height: screenHeight / 7,
                child: Lottie.asset("assets/B.json"),
              ),
              Container(
                height: screenHeight / 7,
                child: Lottie.asset("assets/E.json"),
              ),
              Container(
                height: screenHeight / 7,
                child: Lottie.asset("assets/T.json"),
              ),
              Container(
                height: screenHeight / 7,
                child: Lottie.asset("assets/A.json"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  "C I N E M A",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: screenHeight / 5,
            child: Lottie.asset("assets/play.json"),
          ),
        ],
      ),
      bottomNavigationBar: GNav(
        selectedIndex: -1,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        gap: 10,
        tabBackgroundColor: Color.fromRGBO(52, 101, 217, 1),
        padding: EdgeInsets.all(10),
        tabMargin: EdgeInsets.only(bottom: 10),
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            text: "Login",
            textColor: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      heightFactor: 0.8,
                      child: LoginDialog(),
                    ),
                  );
                },
              );
            },
          ),
          GButton(
            icon: Icons.app_registration,
            text: "Register",
            textColor: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      heightFactor: 0.8,
                      child: RegisterDialog(),
                    ),
                  );
                },
              );
            },
          ),
          GButton(
            icon: Icons.question_answer,
            text: "Thắc mắc",
            textColor: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      heightFactor: 0.8,
                      child: RetrieveDialog(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

void signIn(BuildContext context, String tk, String mk, String name) async {
  try {
    final auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: tk,
      password: mk,
    );
    // Đăng nhập thành công, chuyển hướng sang màn hình khác
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => homePage(
          name: name,
        ),
      ),
    );
  } catch (e) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text('Tài khoản hoặc mật khẩu không chính xác!'),
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

class LoginDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromRGBO(159, 182, 237, 1),
      child: Padding(
        padding: EdgeInsets.only(
          top: 50,
          left: 20,
          right: 20,
        ),
        child: Container(
          child: Column(
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: _tkController,
                decoration: InputDecoration(hintText: "Email:"),
              ),
              TextField(
                obscureText: true,
                controller: _mkController,
                decoration: InputDecoration(
                  hintText: "Mật khẩu: ",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  signIn(context, _tkController.text, _mkController.text,
                      _nameUser.text);
                },
                child: Icon(Icons.login),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromRGBO(159, 182, 237, 1),
      child: Padding(
        padding: EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
        ),
        child: Container(
          child: Column(
            children: [
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: _tkController,
                decoration: InputDecoration(hintText: "Email:"),
              ),
              TextField(
                controller: _nameUser,
                decoration: InputDecoration(
                  hintText: "Họ và tên:",
                ),
              ),
              TextField(
                obscureText: true,
                controller: _mkController,
                decoration: InputDecoration(hintText: "Mật khẩu: "),
              ),
              TextField(
                obscureText: true,
                controller: _verifyPassWord,
                decoration: InputDecoration(
                  hintText: "Nhập lại mật khẩu: ",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  final auth = FirebaseAuth.instance;
                  auth.createUserWithEmailAndPassword(
                      email: _tkController.text, password: _mkController.text);
                  Navigator.pop(context);
                  _tkController.text = _mkController.text = "";
                  // Hiển thị thông báo đăng kí thành công
                  final snackBar = SnackBar(
                    content: Text('Đăng kí thành công!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // Đóng thông báo sau 2 giây
                  Timer(
                    Duration(seconds: 2),
                    () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  );
                },
                child: Icon(Icons.app_registration_sharp),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RetrieveDialog extends StatelessWidget {
  const RetrieveDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromRGBO(159, 182, 237, 1),
      child: Padding(
        padding: EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                "Retrieve PassWord",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _tkController,
                decoration: InputDecoration(hintText: "Email:"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.restore),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
