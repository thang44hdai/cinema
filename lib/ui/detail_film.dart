import 'package:cinema/models/constants.dart';
import 'package:cinema/models/movie.dart';
import 'package:flutter/material.dart';

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
          Image(
            width: widthScreen,
            image: NetworkImage(
              "${Constants.imagePath}${movie.backdrop_path}",
            ),
            fit: BoxFit.cover,
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
      )),
    );
  }
}
