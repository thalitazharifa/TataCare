import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hospital/screens/Kalkulator.dart';

import 'BMI.dart';
import 'Home.dart';

class GrafikPage extends StatefulWidget {
  const GrafikPage({Key? key}) : super(key: key);

  @override
  _GrafikPageState createState() => _GrafikPageState();
}

class _GrafikPageState extends State<GrafikPage> {
  List<FlSpot> data = [
    FlSpot(0, 7),  // Misalnya, 7 jam tidur pada hari 0
    FlSpot(1, 6),  // 6 jam tidur pada hari 1
    FlSpot(2, 8),  // 8 jam tidur pada hari 2
    FlSpot(3, 7),  // 7 jam tidur pada hari 3
    FlSpot(4, 6),  // 6 jam tidur pada hari 4
    FlSpot(5, 8),  // 8 jam tidur pada hari 5
  ];

  TextEditingController jamTidurController = TextEditingController();
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Sleeptime Graph',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1.70,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        margin: 12,
                        getTitles: (value) {
                          return "${value.toInt()}h";  // Menampilkan label jam tidur di sumbu Y
                        },
                      ),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTitles: (value) {
                          return "Day ${value.toInt()}";  // Menampilkan label hari di sumbu X
                        },
                        margin: 12,
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        left: BorderSide(
                          color: const Color(0xff37434d),
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: const Color(0xff37434d),
                          width: 1,
                        ),
                      ),
                    ),
                    minX: 0,
                    maxX: 5,
                    minY: 0,
                    maxY: 10,  // Mengatur rentang jam tidur yang sesuai
                    gridData: FlGridData(
                      show: true,
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: data,
                        isCurved: true,
                        colors: [Colors.blue.shade900],
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Add Sleep Hours: "),
                  SizedBox(width: 20),
                  Container(
                    width: 80,
                    child: TextFormField(
                      controller: jamTidurController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      double newValue = double.tryParse(jamTidurController.text) ?? 0;
                      if (newValue >= 0 && newValue <= 24) {
                        setState(() {
                          data.add(FlSpot(data.length.toDouble(), newValue));
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                      fixedSize: Size(300, 40),
                    ),
                    child: Text("Add to Graph"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        data.clear();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                      fixedSize: Size(300, 40),
                    ),
                    child: Text("Clear Graph"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        items: [
          Icon(Icons.home_filled, color: Colors.black, size: 30),
          Icon(Icons.calculate, color: Colors.black, size: 30),
          Icon(Icons.whatshot_outlined, color: Colors.black, size: 30),
          Icon(Icons.graphic_eq_rounded, color: Colors.black, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Home(); // Navigate to the Home page
              }));
            } else if (_currentIndex == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Kalkulator(); // Navigate to the Kalkulator page
              }));
            } else if (_currentIndex == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BMI(); // Navigate to the BMI page
              }));
            }
          });
        },
        index: _currentIndex,
      ),
    );
  }
}
