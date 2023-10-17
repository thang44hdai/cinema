import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/menu_food.dart';

class ViewModel {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<food> menu = [];

  Stream<List<food>> getAll() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        firestore.collection("food").snapshots();
    return firestore.collection("food").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        food fo = food.fromFirestore(doc);
        return fo;
      }).toList();
    });
  }
}
