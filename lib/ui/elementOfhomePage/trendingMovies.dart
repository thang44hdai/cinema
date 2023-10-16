import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../models/constants.dart';

class trendingMovies extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const trendingMovies({required this.snapshot, super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index, pageIndex) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: 30,
            width: 180,
            color: Colors.amber,
            child: Image(
              image: NetworkImage(
                  '${Constants.imagePath}${snapshot.data[index].poster_path}'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(milliseconds: 3000),
        viewportFraction: 0.5,
        enlargeCenterPage: true, // cho layout chinh giữa to nhất
      ),
    );
  }
}
