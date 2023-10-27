import 'package:flutter/material.dart';
import 'loginPage.dart';

class requestLogin extends StatelessWidget {
  const requestLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
      ),
      body: ListView(
        children: [
          Image(
            image: AssetImage('assets/welcome.png'),
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Bạn chưa đăng nhập!",
              style: TextStyle(
                  color: Color.fromRGBO(1, 81, 152, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "Please log in your information",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => loginPage()));
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
          ),
        ],
      ),
    );
  }
}
