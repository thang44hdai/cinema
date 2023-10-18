import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class seatSidePage extends StatefulWidget {
  const seatSidePage({super.key});

  @override
  State<seatSidePage> createState() => _seatSidePageState();
}

class _seatSidePageState extends State<seatSidePage> {
  List<List<bool>> seatStatus = [];
  int money = 0;

  @override
  void initState() {
    super.initState();
    // Khởi tạo mảng seatStatus với tất cả ghế là trống (false)
    seatStatus = List.generate(10, (row) => List.generate(10, (col) => false));
  }

  void toggleSeatStatus(int row, int col) {
    setState(() {
      seatStatus[row][col] = !seatStatus[row][col];
      if (seatStatus[row][col] == true)
        money += 45000;
      else
        money -= 45000;
    });
  }

  String seat(int row, int col) {
    String s = String.fromCharCode(65 + row);
    return s + col.toString();
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
                      "Ghế đang được giữ",
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
                      width: 22,
                      height: 22,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color:
                            seatStatus[row][col] ? Colors.blue : Colors.green,
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
            text: "  Pay ${money}  ",
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
