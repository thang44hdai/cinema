import 'dart:math';

import 'package:cinema/models/theater.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../models/constants.dart';
import '../models/user.dart';

class seatSidePage extends StatefulWidget {
  const seatSidePage({required this.Theater, super.key});

  final theater Theater;

  @override
  State<seatSidePage> createState() => _seatSidePageState();
}

class _seatSidePageState extends State<seatSidePage> {
  List<List<int>> seatStatus = [];
  int money = 0;
  List<List<int>> picked = [];
  user User = Constants.User;

  @override
  void initState() {
    super.initState();
    // Khởi tạo mảng seatStatus với tất cả ghế là trống (false)
    seatStatus = List.generate(10, (row) => List.generate(10, (col) => 0));
    List<String> booked = widget.Theater.seat;
    if (booked.length > 0) {
      for (String i in booked) {
        int x = int.parse(i[0]);
        int y = int.parse(i[1]);
        seatStatus[x][y] = 2;
      }
    }
  }

  void toggleSeatStatus(int row, int col) {
    setState(() {
      if (seatStatus[row][col] == 0) {
        picked.add([row, col]);
        seatStatus[row][col] = 1;
      } else if (seatStatus[row][col] == 1) {
        List<int> l = [row, col];
        picked.removeWhere((element) => element == l);
        seatStatus[row][col] = 0;
      }
      if (seatStatus[row][col] == 1)
        money += 45000;
      else
        money -= 45000;
    });
    print(picked);
  }

  Color setColorSeat(int row, int col) {
    if (seatStatus[row][col] == 0) {
      return Colors.green;
    } else if (seatStatus[row][col] == 1) {
      return Colors.blue;
    } else {
      return Colors.red;
    }
  }

  String seat(int row, int col) {
    String s = String.fromCharCode(65 + row);
    return s + col.toString();
  }

  void updateUser_and_Theater() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc("${User.account}${User.password}")
        .get();
    DocumentSnapshot documentSnapshot2 = await FirebaseFirestore.instance
        .collection("theater")
        .doc(widget.Theater.doc)
        .get();
    // Lấy giá trị của field ticket
    final _ticket = documentSnapshot.get("ticket") as List<dynamic>;
    final ticket = _ticket.cast<String>().toList();
    final _Seat = documentSnapshot2.get('seat') as List<dynamic>;
    final Seat = _Seat.cast<String>().toList();
    // Cập nhật giá trị của field ticket
    for (List<int> i in picked) {
      if (seatStatus[i[0]][i[1]] == 2) {
        String seat = i[0].toString() + i[1].toString();
        ticket.add(seat+widget.Theater.doc);
        Seat.add(seat);
      }
    }

    // Update document
    await FirebaseFirestore.instance
        .collection("users")
        .doc("${User.account}${User.password}")
        .update({"ticket": ticket});
    await FirebaseFirestore.instance
        .collection("theater")
        .doc(widget.Theater.doc)
        .update({"seat": Seat});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn ghế'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            height: 120,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      "Ghế trống",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.black,
                          )),
                    ),
                    Text(
                      "Ghế đang giữ",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(
                            color: Colors.black,
                          )),
                    ),
                    Text(
                      "Ghế đã bán",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.attach_money),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Giá vé: 45.000 /1 vé",
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              child: Text(
                "MÀN HÌNH CHIẾU",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Column(
            children: List.generate(10, (row) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(10, (col) {
                  return GestureDetector(
                    onTap: () {
                      toggleSeatStatus(row, col);
                    },
                    child: Container(
                      child: Text("${seat(row, col)}"),
                      width: 26,
                      height: 26,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: setColorSeat(row, col),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: GNav(
        selectedIndex: 0,
        tabBackgroundColor: Colors.blue,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        padding: EdgeInsets.all(10),
        tabMargin: EdgeInsets.only(bottom: 10),
        tabs: [
          GButton(
            onPressed: () {
              if (money > 0) {
                setState(() {
                  for (List<int> i in picked) {
                    if (seatStatus[i[0]][i[1]] == 1) {
                      seatStatus[i[0]][i[1]] = 2;
                      String seat = i[0].toString() + i[1].toString();
                      picked.remove([i[0], i[1]]);
                      print(seat);
                      updateUser_and_Theater();
                    } else {
                      picked.remove([i[0], i[1]]);
                    }
                  }
                  money = 0;
                });
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Chúc mừng'),
                      content: Text("Đặt hàng thành công"),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thông báo'),
                      content: Text("Xin mời chọn ghế"),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            icon: Icons.attach_money_sharp,
            iconColor: Colors.white,
            text: "  Pay ${money}  ",
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
