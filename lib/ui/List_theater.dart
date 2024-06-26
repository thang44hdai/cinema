import 'package:cinema/models/constants.dart';
import 'package:cinema/models/theater.dart';
import 'package:cinema/models/user.dart';
import 'package:cinema/ui/seatSitePage.dart';
import 'package:cinema/viewmodel/ViewModel.dart';
import 'package:flutter/material.dart';


class List_Theater extends StatelessWidget {
  const List_Theater({super.key});
  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = ViewModel();
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return StreamBuilder<List<theater>>(
      stream: viewModel.getTheater(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Loi: ${snapshot.error}");
        } else {
          List<theater> the = snapshot.data ?? [];
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Danh sách rạp chiếu",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            body: ListView.builder(
              itemCount: the.length,
              itemBuilder: (context, index) {
                return Container(
                  width: widthScreen,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => seatSidePage(Theater: the[index]),
                        ),
                      );
                    },
                    leading: Icon(Icons.location_city),
                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 60,
                        color: Colors.white,
                        child: Image(
                          image: NetworkImage(Constants.logo),
                        ),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${the[index].name}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${the[index].location}",
                          maxLines: 3,
                          overflow: TextOverflow.visible,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
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
