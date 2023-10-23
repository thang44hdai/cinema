import 'package:cinema/models/constants.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class inforPage extends StatefulWidget {
  const inforPage({super.key});

  @override
  State<inforPage> createState() => _inforPageState();
}

class _inforPageState extends State<inforPage> {
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            child: Image(
              image: AssetImage("assets/counter.png"),
            ),
          ),
          Positioned(
            child: CircleAvatar(
              child: ,
            ),
          ),
        ],
      ),
    );
  }
}
