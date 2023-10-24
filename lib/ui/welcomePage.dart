import 'dart:async';
import 'package:cinema/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';
import '../models/constants.dart';
import 'homePage.dart';

TextEditingController _tk_registerController = TextEditingController();
TextEditingController _mk_registerController = TextEditingController();
TextEditingController _verifyPassWordController = TextEditingController();
TextEditingController _tk_loginController = TextEditingController();
TextEditingController _mk_loginController = TextEditingController();
TextEditingController _nameUserController = TextEditingController();

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
            height: 40,
          ),
          Center(
            child: Container(
              height: screenHeight / 3,
              child: Lottie.asset("assets/cinema.json"),
            ),
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

class LoginDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          top: 50,
          left: 10,
          right: 10,
        ),
        child: Container(
          child: Column(
            children: [
              Container(
                child: Image.asset('assets/welcome.png'),
                height: 80,
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(
                  Icons.email,
                  color: Color.fromRGBO(7, 9, 133, 1),
                ),
                title: TextField(
                  controller: _tk_loginController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(7, 9, 133, 1),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Email:",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(7, 9, 133, 1),
                    ),
                  ),
                  style: TextStyle(
                    color: Color.fromRGBO(7, 9, 133, 1),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Icons.lock,
                  color: Color.fromRGBO(7, 9, 133, 1),
                ),
                title: TextField(
                  obscureText: true,
                  controller: _mk_loginController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(7, 9, 133, 1),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Mật khẩu: ",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(7, 9, 133, 1),
                    ),
                  ),
                  style: TextStyle(
                    color: Color.fromRGBO(7, 9, 133, 1),
                  ),
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
                child: Icon(
                  Icons.login,
                  color: Color.fromRGBO(7, 9, 133, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class RegisterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
        ),
        child: Container(
          child: Column(
            children: [
              Container(
                height: 50,
                child: Image(
                  image: AssetImage('assets/welcome.png'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _tk_registerController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(7, 9, 133, 1),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    icon: Icon(
                      Icons.email,
                      color: Color.fromRGBO(7, 9, 133, 1),
                    ),
                    hintText: "Email:",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(7, 9, 133, 1),
                    )),
                style: TextStyle(
                  color: Color.fromRGBO(7, 9, 133, 1),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              TextField(
                controller: _nameUserController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(7, 9, 133, 1),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    icon: Icon(
                      Icons.person,
                      color: Color.fromRGBO(7, 9, 133, 1),
                    ),
                    hintText: "Họ và tên:",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(7, 9, 133, 1),
                    )),
                style: TextStyle(
                  color: Color.fromRGBO(7, 9, 133, 1),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              TextField(
                obscureText: true,
                controller: _mk_registerController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(7, 9, 133, 1),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: Color.fromRGBO(7, 9, 133, 1),
                    ),
                    hintText: "Mật khẩu:",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(7, 9, 133, 1),
                    )),
                style: TextStyle(
                  color: Color.fromRGBO(7, 9, 133, 1),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              TextField(
                obscureText: true,
                controller: _verifyPassWordController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(7, 9, 133, 1),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: Color.fromRGBO(7, 9, 133, 1),
                    ),
                    hintText: "Nhập lại mật khẩu:",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(7, 9, 133, 1),
                    )),
                style: TextStyle(
                  color: Color.fromRGBO(7, 9, 133, 1),
                ),
              ),
              SizedBox(
                height: 20,
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
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // Đóng thông báo sau 2 giây
                  Timer(
                    Duration(seconds: 2),
                    () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  );
                },
                child: Icon(
                  Icons.app_registration_sharp,
                  color: Color.fromRGBO(7, 9, 133, 1),
                ),
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
      backgroundColor: Colors.white,
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
                  color: Color.fromRGBO(7, 9, 133, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: _tk_loginController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(7, 9, 133, 1),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    icon: Icon(
                      Icons.email,
                      color: Color.fromRGBO(7, 9, 133, 1),
                    ),
                    hintText: "Email:",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(7, 9, 133, 1),
                    )),
                style: TextStyle(
                  color: Color.fromRGBO(7, 9, 133, 1),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(
                  Icons.restore,
                  color: Color.fromRGBO(7, 9, 133, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
