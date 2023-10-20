import 'package:cinema/models/menu_food.dart';
import 'package:cinema/ui/elementOfhomePage/food_screen.dart';
import 'package:cinema/ui/elementOfhomePage/isPlayingMovies.dart';
import 'package:cinema/ui/elementOfhomePage/trendingMovies.dart';
import 'package:cinema/ui/elementOfhomePage/upComingMovies.dart';
import 'package:cinema/viewmodel/ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../network/api.dart';
import '../models/movie.dart';

class homePage extends StatefulWidget {
  final String name;

  const homePage({required this.name, super.key});

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

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello ${widget.name}"),
        leading: Container(
          padding: EdgeInsets.only(left: 10),
          height: 50,
          width: 50,
          child: Image(
            image: NetworkImage(
                "https://cdn.mservice.com.vn/app/img/booking/logo_beta.png"),
          ),
        ),
      ),
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trending Movies
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "Trending",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                "Popcorn and Drink",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
