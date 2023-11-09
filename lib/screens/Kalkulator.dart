import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hospital/screens/Home.dart';
import 'package:hospital/screens/BMI.dart';
import 'package:hospital/screens/Grafik.dart';

class Kalkulator extends StatefulWidget {
  @override
  _KalkulatorState createState() => _KalkulatorState();
}

class _KalkulatorState extends State<Kalkulator> {
  TextEditingController inputController1 = TextEditingController();
  TextEditingController inputController2 = TextEditingController();
  TextEditingController resultController = TextEditingController();
  String selectedOperation = '+';
  List<String> history = [];
  int _currentIndex = 1;

  void calculate() {
    double num1 = double.tryParse(inputController1.text) ?? 0.0;
    double num2 = double.tryParse(inputController2.text) ?? 0.0;

    double result = 0;

    switch (selectedOperation) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        if (num2 != 0) {
          result = num1 / num2;
        }
        break;
    }

    resultController.text = result.toStringAsFixed(2);
    history.add('$num1 $selectedOperation $num2 = $result');
  }

  void clear() {
    inputController1.clear();
    inputController2.clear();
    resultController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Calculator',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                controller: inputController1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Input 1',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                controller: inputController2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Input 2',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                controller: resultController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Result',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RoundedButton(
                  text: '+',
                  onPressed: () {
                    setState(() {
                      selectedOperation = '+';
                      calculate();
                    });
                  },
                ),
                RoundedButton(
                  text: '-',
                  onPressed: () {
                    setState(() {
                      selectedOperation = '-';
                      calculate();
                    });
                  },
                ),
                RoundedButton(
                  text: '*',
                  onPressed: () {
                    setState(() {
                      selectedOperation = '*';
                      calculate();
                    });
                  },
                ),
                RoundedButton(
                  text: '/',
                  onPressed: () {
                    setState(() {
                      selectedOperation = '/';
                      calculate();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        clear();
                      });
                    },
                    child: Text(
                      'Clear',
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        history[index],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        items: [
          Icon(Icons.home_filled, color: Colors.black, size: 30), // Home page
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
            } else if (_currentIndex == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BMI(); // Navigate to the BMI page
              }));
            } else if (_currentIndex == 3) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GrafikPage(); // Navigate to the Grafik page
              }));
            }
          });
        },
        index: _currentIndex,
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  RoundedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue.shade900,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Kalkulator(),
  ));
}
