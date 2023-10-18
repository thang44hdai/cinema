import 'package:cloud_firestore/cloud_firestore.dart';

class theater {
  String name;
  String location;
  List<String> seat;

  theater({required this.name, required this.location, required this.seat});

  factory theater.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final seatList = data['seat'] as List<dynamic>;
    final seat = seatList.cast<String>().toList();


    return theater(
      name: data['name'],
      location: data['location'],
      seat: seat,
    );
  }
}
