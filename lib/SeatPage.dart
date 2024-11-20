import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Cupertino dialog 사용

void main() {
  runApp(const TrainSeatBookingApp());
}

class TrainSeatBookingApp extends StatelessWidget {
  const TrainSeatBookingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SeatSelectionScreen(
        departureStation: "수서",
        arrivalStation: "부산",
      ),
    );
  }
}

// 예매 좌석 선택 페이지
class SeatSelectionScreen extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  SeatSelectionScreen({
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final List<List<bool>> seatSelected =
      List.generate(20, (_) => List.generate(4, (_) => false));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '좌석 선택',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.departureStation,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_circle_right_outlined, size: 30),
                Expanded(
                  child: Text(
                    widget.arrivalStation,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSeatLegend(Colors.purple, "선택됨"),
                const SizedBox(width: 20),
                _buildSeatLegend(Colors.grey[300]!, "선택안됨"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // 열 이름 (A, B, C, D) 추가 - 좌석 바로 위에 위치
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
          
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, rowIndex) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      if (rowIndex == 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSeatLabel('A'),
                              const SizedBox(width: 5),
                              _buildSeatLabel('B'),
                              const SizedBox(width: 80), // AB와 CD 사이의 간격
                              _buildSeatLabel('C'),
                              const SizedBox(width: 5),
                              _buildSeatLabel('D'),
                            ],
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 좌측 AB 좌석
                          ...List.generate(2, (columnIndex) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      seatSelected[rowIndex][columnIndex] =
                                          !seatSelected[rowIndex][columnIndex];
                                    });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: seatSelected[rowIndex][columnIndex]
                                          ? Colors.purple
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                if (columnIndex < 1) const SizedBox(width: 4),
                              ],
                            );
                          }),
                          const SizedBox(width: 16), // AB와 숫자 간격
                          _buildLabel("${rowIndex + 1}"),
                          const SizedBox(width: 16), // 숫자와 CD 간격
                          // 우측 CD 좌석
                          ...List.generate(2, (columnIndex) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      seatSelected[rowIndex][columnIndex + 2] =
                                          !seatSelected[rowIndex][columnIndex + 2];
                                    });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: seatSelected[rowIndex][columnIndex + 2]
                                          ? Colors.purple
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                if (columnIndex < 1) const SizedBox(width: 4),
                              ],
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(
              onPressed: _onReservePressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "예매 하기",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onReservePressed() {
    bool anySeatSelected = seatSelected.any((row) => row.contains(true));
    if (!anySeatSelected) {
      return; // 선택된 좌석이 없으면 아무런 반응 X
    }

    List<String> selectedSeats = [];
    for (int rowIndex = 0; rowIndex < seatSelected.length; rowIndex++) {
      for (int columnIndex = 0; columnIndex < seatSelected[rowIndex].length; columnIndex++) {
        if (seatSelected[rowIndex][columnIndex]) {
          String seatLabel = "${rowIndex + 1}-${String.fromCharCode(65 + columnIndex)}";
          selectedSeats.add(seatLabel);
        }
      }
    }

    String selectedSeatsText = selectedSeats.join(", ");

    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("예매 하시겠습니까?"),
        content: Text("좌석: $selectedSeatsText"),
        actions: [
          CupertinoDialogAction(
            child: const Text("취소"),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: const Text("확인"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // 이전 화면으로 돌아가기
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildSeatLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  Widget _buildSeatLabel(String label) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
