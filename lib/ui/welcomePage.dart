import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

TextEditingController _tkController = TextEditingController();
TextEditingController _mkController = TextEditingController();
TextEditingController _verifyPassWord = TextEditingController();

class welcomePage extends StatelessWidget {
  const welcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: GNav(
        selectedIndex: -1,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        gap: 10,
        tabBackgroundColor: Colors.lightBlueAccent,
        padding: EdgeInsets.all(10),
        tabMargin: EdgeInsets.only(bottom: 10),
        tabs: [
          GButton(
            icon: Icons.home,
            text: "Login",
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      heightFactor: 0.48,
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      heightFactor: 0.5,
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      heightFactor: 0.5,
                      child: RetrieveDialog(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
            child: Container(
              height: screenHeight / 4,
              width: screenWidth,
              color: Colors.black12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class LoginDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: _tkController,
                decoration: InputDecoration(hintText: "Email:"),
              ),
              TextField(
                controller: _mkController,
                decoration: InputDecoration(hintText: "Mật khẩu: "),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
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
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: _tkController,
                decoration: InputDecoration(hintText: "Email:"),
              ),
              TextField(
                controller: _mkController,
                decoration: InputDecoration(hintText: "Mật khẩu: "),
              ),
              TextField(
                controller: _verifyPassWord,
                decoration: InputDecoration(hintText: "Nhập lại mật khẩu: "),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
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
                style: TextStyle(fontSize: 20),
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
