import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/menu_food.dart';

class ViewModel {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<food> menu = [];

  Future<List<food>> read_data() async {
    try {
      await firestore.collection("food").get().then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot document) {
          final Map<String, dynamic> mp =
              document.data() as Map<String, dynamic>;
          menu.add(food(image: mp['image'], name: mp['name']));
        });
      });
      return menu;
    } catch (e) {
      print("Error $e");
      return [];
    }
  }
}
