import 'dart:async';
import 'package:cinema/models/user.dart';
import 'package:cinema/ui/loginPage.dart';
import 'package:cinema/ui/signupPage.dart';
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
        tabBackgroundColor: Color.fromRGBO(1, 81, 152, 1),
        padding: EdgeInsets.all(10),
        tabMargin: EdgeInsets.only(bottom: 10),
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            text: "Login",
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>loginPage()));
            },
          ),
          GButton(
            icon: Icons.app_registration,
            text: "Register",
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>signupPage()));
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
                  color: Color.fromRGBO(1, 81, 152, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                obscureText: true,
                controller: _tk_loginController,
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
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Color.fromRGBO(1, 81, 152, 1),
                  elevation: 20,
                  shadowColor: Color.fromRGBO(1, 81, 152, 1),
                  minimumSize: Size.fromHeight(60),
                ),
                child: Icon(
                  Icons.restore,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
