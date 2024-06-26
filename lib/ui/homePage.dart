import 'package:cinema/ui/elementOfhomePage/food_screen.dart';
import 'package:cinema/ui/elementOfhomePage/isPlayingMovies.dart';
import 'package:cinema/ui/elementOfhomePage/trendingMovies.dart';
import 'package:cinema/ui/elementOfhomePage/upComingMovies.dart';
import 'package:cinema/ui/loginPage.dart';
import 'package:cinema/ui/profilePage.dart';
import 'package:flutter/material.dart';
import '../models/constants.dart';
import '../models/user.dart';
import '../network/api.dart';
import '../models/movie.dart';

class homePage extends StatefulWidget {
  final user User;

  const homePage({required this.User, super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late Future<List<Movie>> future_trendingMovie;
  late Future<List<Movie>> future_isPlayingMovie;
  late Future<List<Movie>> future_upComingMovie;

  @override
  void initState() {
    super.initState();
    future_trendingMovie = Api().getTrendingMovies();
    future_isPlayingMovie = Api().getIsPlayingMovies();
    future_upComingMovie = Api().getUpComingMovies();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Widget LoginButton() {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => loginPage(),
            ),
          );
        },
        child: Text(
          "Log In",
        ),
      );
    }

    Widget SignUpButton() {
      return ElevatedButton(
          onPressed: () {
            Constants.login_state = 0;
            Constants.User = user(
                name: "friend",
                account: "account",
                password: "password",
                ticket: []);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => homePage(User: Constants.User)));
          },
          child: Text(
            "Log Out",
          ));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 81, 152, 1),
        title: Text(
          "Hello ${Constants.User.name}",
          style: TextStyle(color: Colors.white),
        ),
        leading: Container(
          padding: EdgeInsets.only(left: 10),
          height: 50,
          width: 50,
          child: Image(
            image: AssetImage("assets/home.png"),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Constants.login_state == 0 ? LoginButton() : SignUpButton(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => inforPage()));
        },
        child: Icon(
          Icons.person_2,
          color: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(1, 81, 152, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trending Movies
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: Container(
                color: Color.fromRGBO(1, 81, 152, 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        "Trending",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: FutureBuilder(
                        future: future_trendingMovie,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("${snapshot.error}"),
                            );
                          } else if (snapshot.hasData) {
                            return trendingMovies(snapshot: snapshot);
                          } else {
                            return Center(
                              child: Container(
                                color: Colors.amber,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Hiện đang khởi chiếu
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 10,
              ),
              child: Text(
                "Hiện đang khởi chiếu",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              child: FutureBuilder(
                future: future_isPlayingMovie,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    return isPlayingMovies(
                      snapshot: snapshot,
                    );
                  } else {
                    return Center(
                      child: Container(
                        color: Colors.amber,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // Sắp phát hành
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 10,
              ),
              child: Text(
                "Sắp phát hành",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              child: FutureBuilder(
                future: future_upComingMovie,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Container(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    return upComingMovies(snapshot: snapshot);
                  } else {
                    return Center(
                      child: Container(
                        color: Colors.amber,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Menu food
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 10,
              ),
              child: Text(
                "Food and Drink",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              child: Food(),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
