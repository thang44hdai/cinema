import 'package:flutter/material.dart';
import 'loginPage.dart';

class requestLogin extends StatelessWidget {
  const requestLogin({super.key});

  @override
  Widget build(BuildContext context) {
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
                  height: 480,
                  width: widthScreen,
                  child: Padding(
                    padding: EdgeInsets.all(28),
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
                          "Bạn chưa đăng nhập!",
                          style: TextStyle(
                              color: Color.fromRGBO(1, 81, 152, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 29),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: Color.fromRGBO(1, 81, 152, 1),
                            elevation: 20,
                            shadowColor: Color.fromRGBO(1, 81, 152, 1),
                            minimumSize: Size.fromHeight(60),
                          ),
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
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
