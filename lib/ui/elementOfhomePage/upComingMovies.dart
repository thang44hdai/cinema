import 'package:flutter/material.dart';
import '../../models/constants.dart';

class upComingMovies extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const upComingMovies({required this.snapshot, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 200,
                width: 200,
                child: Image(
                  image: NetworkImage(
                      '${Constants.imagePath}${snapshot.data[index].poster_path}'),
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
}
