import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            (ModalRoute.of(context)?.settings.arguments as String) == '출발역' ? '출발역' : '도착역',
            style: TextStyle(), // 별도의 스타일 지정 없이 중앙정렬
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 250.0),
        children: [
          _buildStationItem(context, '수서'),
          _buildStationItem(context, '동탄'),
          _buildStationItem(context, '평택지제'),
          _buildStationItem(context, '천안아산'),
          _buildStationItem(context, '오송'),
          _buildStationItem(context, '대전'),
          _buildStationItem(context, '김천구미'),
          _buildStationItem(context, '동대구'),
          _buildStationItem(context, '경주'),
          _buildStationItem(context, '울산'),
          _buildStationItem(context, '부산'),
        ],
      ),
    );
  }

  Widget _buildStationItem(BuildContext context, String stationName) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, stationName);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300]!,
            ),
          ),
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          stationName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: HomePage(),
));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departureStation;
  String? arrivalStation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기차역 선택'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text(departureStation ?? '출발역을 선택하세요'),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StationListPage(),
                  settings: RouteSettings(arguments: '출발역'),
                ),
              );
              if (result != null) {
                setState(() {
                  departureStation = result;
                });
              }
            },
          ),
          ListTile(
            title: Text(arrivalStation ?? '도착역을 선택하세요'),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StationListPage(),
                  settings: RouteSettings(arguments: '도착역'),
                ),
              );
              if (result != null) {
                setState(() {
                  arrivalStation = result;
                });
              }
            },
          ),
        ],
      ),
    );
  }
} 