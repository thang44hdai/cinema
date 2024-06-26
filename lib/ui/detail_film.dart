import 'package:cinema/models/constants.dart';
import 'package:cinema/models/movie.dart';
import 'package:cinema/ui/List_theater.dart';
import 'package:cinema/ui/requestLoginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class detail_film extends StatelessWidget {
  final Movie movie;

  const detail_film({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: movie.title,
                  child: Image(
                    width: widthScreen,
                    image: NetworkImage(
                      "${Constants.imagePath}${movie.backdrop_path}",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 20,
                  child: IconButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.grey)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${movie.title}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("${movie.overview}"),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range),
                          SizedBox(
                            width: 5,
                          ),
                          Text("${movie.release_date}"),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Icon(Icons.favorite),
                          SizedBox(
                            width: 5,
                          ),
                          Text("${movie.popularity}"),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Icon(Icons.share),
                          SizedBox(
                            width: 5,
                          ),
                          Text("${movie.vote_count}"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GNav(
        selectedIndex: 0,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        gap: 10,
        color: Colors.blue,
        tabBackgroundColor: Color.fromRGBO(52, 101, 217, 1),
        padding: EdgeInsets.all(10),
        tabMargin: EdgeInsets.only(bottom: 10),
        tabs: [
          GButton(
            icon: Icons.theaters,
            text: "Buy the ticket",
            textColor: Colors.white,
            onPressed: () {
              if (Constants.login_state == 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => List_Theater()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => requestLogin()));
              }
            },
          ),
        ],
      ),
    );
  }
}
