import 'package:cloud_firestore/cloud_firestore.dart';

class food {
  String image;
  String name;

  food({required this.image, required this.name});

  factory food.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return food(
      image: data['image'],
      name: data['name'],
    );
  }
}
