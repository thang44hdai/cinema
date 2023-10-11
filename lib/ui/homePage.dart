import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class homePage extends StatefulWidget {
  final String name;

  const homePage({required this.name, super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
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
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "Trending Movies in Beta",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              child: CarouselSlider.builder(
                itemCount: 2,
                itemBuilder: (context, index, pageIndex) {
                  return Container(
                      height: 30,
                      width: 180,
                      color: Colors.amber,
                      child: Lottie.asset("assets/animation.json"));
                },
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(milliseconds: 3000),
                  viewportFraction: 0.5,
                  enlargeCenterPage: true,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                    color: Colors.amber,
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
          ],
        ),
      ),
    );
  }
}
