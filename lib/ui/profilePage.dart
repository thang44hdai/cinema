import 'package:cinema/models/constants.dart';
import 'package:cinema/ui/loginPage.dart';
import 'package:cinema/ui/requestLoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../models/user.dart';

class inforPage extends StatefulWidget {
  const inforPage({super.key});

  @override
  State<inforPage> createState() => _inforPageState();
}

late double heightScreen, widthScreen;
int fragment = 1;
List<String> ve = [];

class _inforPageState extends State<inforPage> {
  @override
  Widget build(BuildContext context) {
    if (Constants.login_state == 1) {
      loadTicket();
      heightScreen = MediaQuery.of(context).size.height;
      widthScreen = MediaQuery.of(context).size.width;
      return Scaffold(
        body: Column(
          children: [
            Container(
              height: 340,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Background(),
                  Ava(),
                ],
              ),
            ),
            Container(
              height: 300,
              child: fragment == 1 ? profile() : ticket(),
            ),
          ],
        ),
        bottomNavigationBar: GNav(
          selectedIndex: 0,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          gap: 10,
          tabBackgroundColor: Color.fromRGBO(52, 101, 217, 1),
          padding: EdgeInsets.all(10),
          tabMargin: EdgeInsets.only(bottom: 10),
          tabs: [
            GButton(
              icon: Icons.person_2,
              text: "Cá nhân",
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  fragment = 1;
                });
              },
            ),
            GButton(
              icon: Icons.movie,
              text: "Vé đặt",
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  fragment = 2;
                });
              },
            ),
          ],
        ),
      );
    } else {
      return requestLogin();
    }
  }
}

Widget Background() {
  return SizedBox(
    child: ClipRRect(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
      child: Image(
        image: AssetImage("assets/counter.png"),
      ),
    ),
  );
}

Widget Ava() {
  return Positioned(
    top: 160,
    left: 110,
    child: Column(
      children: [
        CircleAvatar(
          radius: widthScreen / 6,
          backgroundImage: AssetImage('assets/ava.jpg'),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          Constants.User.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    ),
  );
}

Widget Content() {
  return Positioned(
    top: 250,
    left: 100,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 20,
            color: Colors.blue,
          )
        ],
      ),
    ),
  );
}

Widget profile() {
  return Padding(
    padding: EdgeInsets.only(left: 50, right: 50),
    child: ListView(
      children: [
        Card(
          child: ListTile(
            leading: Icon(Icons.email),
            title: Text(
              Constants.User.account,
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.phone),
            title: Text("03651898989"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.location_history),
            title: Text("Hà Nội, Việt Nam"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.facebook),
            title: Text("facebook.com/profile.php?id=100015341652892"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.school),
            title: Text("Test"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.location_history),
            title: Text("Hà Nội, Việt Nam"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.location_history),
            title: Text("Hà Nội, Việt Nam"),
          ),
        ),
      ],
    ),
  );
}

Future<void> loadTicket() async {
  final firestore = await FirebaseFirestore.instance
      .collection("users")
      .doc(Constants.User.account + Constants.User.password)
      .get();
  final _ticket = firestore.get("ticket") as List<dynamic>;
  final Ticket = _ticket.cast<String>().toList();
  ve = Ticket;
}

Future<String> loadTheater(String doc) async {
  final firestore =
      await FirebaseFirestore.instance.collection("theater").doc(doc).get();
  final thea = firestore.get("name") as String;
  return thea;
}

Widget ticket() {
  return Padding(
    padding: EdgeInsets.only(left: 50, right: 50),
    child: ListView.builder(
      itemCount: ve.length,
      itemBuilder: (context, index) {
        // xu ly ghe ngoi va rap chieu
        String Ve = ve[index];
        int idxRow = Ve.substring(0, 1).codeUnitAt(0) - "0".codeUnitAt(0) + 65;
        String row = String.fromCharCode(idxRow);
        String col = Ve.substring(1, 2);
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.event_seat),
                title: Text("$row$col"),
              ),
              ListTile(
                leading: Icon(Icons.theaters),
                title: FutureBuilder(
                  future: loadTheater(Ve.substring(2)),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Beta Cinema");
                    } else if (snapshot.hasData) {
                      return Text(snapshot.data.toString());
                    } else
                      return Text("Beta Cinema");
                  },
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
