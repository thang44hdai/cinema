import 'package:cinema/viewmodel/ViewModel.dart';
import 'package:flutter/material.dart';

class Food extends StatelessWidget {
  final AsyncSnapshot vm;
  const Food({required this.vm, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 10),
            height: 200,
            width: 200,
            color: Colors.green,
          );
        },
      ),
    );
  }
}
