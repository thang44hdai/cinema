import 'package:cinema/ui/elementOfhomePage/trendingMovies.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/api.dart';
import '../models/movie.dart';

class homePage extends StatefulWidget {
  final String name;

  const homePage({required this.name, super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late Future<List<Movie>> future_trendingMovie;

  @override
  void initState() {
    super.initState();
    future_trendingMovie = Api().getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello ${widget.name}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trending Movies
            Padding(
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
                    } else
                      return Center(
                        child: Container(
                          color: Colors.amber,
                        )
                      );
                  }),
            ),
            SizedBox(
              height: 20,
            ),

            // Hiện đang khởi chiếu
            Padding(
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
                    child: Image(
                      image: NetworkImage(
                          "https://thumbs.dreamstime.com/b/bridges-movie-standee-american-action-thriller-film-directed-brian-kirk-kuala-lumpur-malaysia-january-170042641.jpg"),
                      height: 200,
                      width: 200,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // Sắp phát hành
            Padding(
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
                    color: Colors.amber,
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // Menu food
            Padding(
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
                    color: Colors.amber,
                  );
                },
              ),
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
