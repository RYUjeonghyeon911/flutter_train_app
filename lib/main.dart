import 'package:flutter/material.dart';
import 'package:flutter_train_app/stationlistpage.dart';

void main() {
  runApp(TrainBookingApp());
}

class TrainBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TrainBookingPage(),
    );
  }
}

class TrainBookingPage extends StatefulWidget {
  @override
  _TrainBookingPageState createState() => _TrainBookingPageState();
}

class _TrainBookingPageState extends State<TrainBookingPage> {
  String? _departureStation;
  String? _arrivalStation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '기차 예매',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.pink[50],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '출발역',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          final selectedStation = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StationListPage()),
                          );
                          if (selectedStation != null) {
                            setState(() {
                              _departureStation = selectedStation;
                            });
                          }
                        },
                        child: Text(
                          _departureStation ?? '선택',
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 2,
                    height: 50,
                    color: Colors.grey[400],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '도착역',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          final selectedStation = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StationListPage()),
                          );
                          if (selectedStation != null) {
                            setState(() {
                              _arrivalStation = selectedStation;
                            });
                          }
                        },
                        child: Text(
                          _arrivalStation ?? '선택',
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 60),
              ),
              onPressed: _departureStation != null && _arrivalStation != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SeatPage()),
                      );
                    }
                  : null,
              child: Text(
                '좌석 선택',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}



class SeatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좌석 선택'),
      ),
      body: Center(
        child: Text('좌석 선택 페이지입니다.'),
      ),
    );
  }
}