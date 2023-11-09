import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hospital/screens/Home.dart';
import 'package:hospital/screens/Kalkulator.dart';
import 'package:hospital/screens/Grafik.dart';

class BMI extends StatefulWidget {
  const BMI({Key? key}) : super(key: key);

  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  double height = 160;
  double weight = 60;
  String gender = "Male";
  double bmi = 0.0;
  String result = "";
  int _currentIndex = 1;

  void calculateBMI() {
    double heightInMeters = height / 100;
    bmi = weight / (heightInMeters * heightInMeters);

    if (bmi < 18.5) {
      result = "Underweight";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      result = "Normal Weight";
    } else if (bmi >= 25 && bmi < 29.9) {
      result = "Overweight";
    } else {
      result = "Obesity";
    }

    setState(() {});
  }

  String getImagePath(String category) {
    switch (category) {
      case "Underweight":
        return "assets/images/underweight.png";
      case "Normal Weight":
        return "assets/images/normal.png";
      case "Overweight":
        return "assets/images/overweight.png";
      case "Obesity":
        return "assets/images/obesity.png";
      default:
        return "assets/images/bmi.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'BMI Calculator',
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
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Enter Your Data", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Height (cm):", style: TextStyle(fontSize: 18, color: Colors.blue.shade900)),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      height = double.tryParse(value) ?? 0;
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Weight (kg):", style: TextStyle(fontSize: 18, color: Colors.blue.shade900)),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      weight = double.tryParse(value) ?? 0;
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gender:", style: TextStyle(fontSize: 18, color: Colors.blue.shade900)),
                DropdownButton<String>(
                  value: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                  items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      calculateBMI();
                    },
                    child: Text("Calculate BMI", style: TextStyle(fontSize: 20, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Your BMI: $bmi", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
            Text("BMI Category: $result", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
            SizedBox(height: 20),
            Image.asset(
              getImagePath(result),
              height: 230,
              width: 230,
            ),
          ],
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
                return Home();
              }));
            } else if (_currentIndex == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Kalkulator();
              }));
            } else if (_currentIndex == 3) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GrafikPage();
              }));
            }
          });
        },
        index: _currentIndex,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BMI(),
  ));
}