import 'package:cinema/models/menu_food.dart';
import 'package:cinema/viewmodel/ViewModel.dart';
import 'package:flutter/material.dart';

class Food extends StatelessWidget {
  const Food({super.key});

  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = ViewModel();
    return StreamBuilder<List<food>>(
      stream: viewModel.getAll(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          List<food> menu = snapshot.data ?? [];
          return Container(
            height: 200,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: menu.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      height: 200,
                      width: 200,
                      color: Colors.green,
                      child: Image(
                        image: NetworkImage(menu[index].image),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
