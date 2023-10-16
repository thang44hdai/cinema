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

const String x1 =
    "https://files.betacorp.vn/files/ecm/2023/10/05/don-thang-quy-di-combo-ma-mi-1702-x-621-shrink-113717-051023-74.jpg";
const String x2 =
    "https://files.betacorp.vn/files/ecm/2023/09/26/vnpaybeta-1702-x-621-145207-260923-41.png";
const String x3 =
    "https://files.betacorp.vn/files/ecm/2023/10/11/1702x621-093810-111023-40.jpg";
const String x4 =
    "https://files.betacorp.vn/files/ecm/2023/09/25/vani-bc-1702x621-copy-133653-250923-54.jpg";
const String x5 =
    "https://files.betacorp.vn/files/ecm/2023/04/21/mer-resize-1702-x-621-140337-210423-86.png";

class welcomePage extends StatelessWidget {
  const welcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<String> film = [x1, x2, x3, x4, x5];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: film.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      width: screenWidth,
                      padding: EdgeInsets.only(top: 20),
                      child: Image(
                        image: NetworkImage(film[index]),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: screenHeight / 5,
                  child: Lottie.asset("assets/B.json"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "e  t  a",
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(18, 36, 64, 1),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Text(
                  "CINEMA",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(18, 36, 64, 1),
                  ),
                ),
              )
            ],
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
