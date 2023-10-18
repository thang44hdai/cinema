import 'package:cloud_firestore/cloud_firestore.dart';

class theater {
  String name;
  String location;

  theater({required this.name, required this.location});
  factory theater.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return theater(
      name: data['name'],
      location: data['location'],
    );
  }
}
