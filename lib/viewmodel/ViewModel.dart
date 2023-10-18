import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/menu_food.dart';
import '../models/theater.dart';

class ViewModel {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<food>> getFood() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        firestore.collection("food").snapshots();
    return snapshot.map((e) {
      return e.docs.map((doc) {
        food fo = food.fromFirestore(doc);
        return fo;
      }).toList();
    });
  }

  Stream<List<theater>> getTheater() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        firestore.collection("theater").snapshots();
    return snapshot.map((event) {
      return event.docs.map((doc) {
        theater the = theater.fromFirestore(doc);
        return the;
      }).toList();
    });
  }

}
