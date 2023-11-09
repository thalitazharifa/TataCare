import 'package:flutter/material.dart';

class KonversiSuhu extends StatefulWidget {
  @override
  _KonversiSuhuState createState() => _KonversiSuhuState();
}

class _KonversiSuhuState extends State<KonversiSuhu> {
  double celsius = 0;
  double fahrenheit = 32;
  double kelvin = 273.15;
  double reamur = 0;
  TextEditingController fahrenheitController = TextEditingController();
  TextEditingController celsiusController = TextEditingController();
  TextEditingController kelvinController = TextEditingController();
  TextEditingController reamurController = TextEditingController();

  void convertToCelsius(double value) {
    setState(() {
      celsius = (value - 32) * 5 / 9;
      celsiusController.text = celsius.toStringAsFixed(2);
      kelvin = celsius + 273.15;
      kelvinController.text = kelvin.toStringAsFixed(2);
      reamur = celsius * 0.8;
      reamurController.text = reamur.toStringAsFixed(2);
    });
  }

  void convertToFahrenheit(double value) {
    setState(() {
      fahrenheit = (value * 9 / 5) + 32;
      fahrenheitController.text = fahrenheit.toStringAsFixed(2);
      kelvin = (value - 32) * 5 / 9 + 273.15;
      kelvinController.text = kelvin.toStringAsFixed(2);
      reamur = (value - 32) * 4 / 9;
      reamurController.text = reamur.toStringAsFixed(2);
    });
  }

  void clearFields() {
    setState(() {
      fahrenheitController.clear();
      celsiusController.clear();
      kelvinController.clear();
      reamurController.clear();
      celsius = 0;
      fahrenheit = 32;
      kelvin = 273.15;
      reamur = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Conversion'),
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: fahrenheitController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Fahrenheit',
                suffixText: '°F',
              ),
              onChanged: (value) {
                double inputValue = double.tryParse(value) ?? 0;
                convertToCelsius(inputValue);
              },
            ),
            SizedBox(height: 20),
            Text(
              'Conversion Results:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '$celsius °C',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            TextField(
              controller: celsiusController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Celsius',
                suffixText: '°C',
              ),
              onChanged: (value) {
                double inputValue = double.tryParse(value) ?? 0;
                convertToFahrenheit(inputValue);
              },
            ),
            SizedBox(height: 20),
            Text(
              'Conversion Results:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '$fahrenheit °F',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            TextField(
              controller: kelvinController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Kelvin',
                suffixText: 'K',
              ),
              onChanged: (value) {
                double inputValue = double.tryParse(value) ?? 0;
                double fahrenheitValue = (inputValue - 273.15) * 9 / 5 + 32;
                fahrenheitController.text = fahrenheitValue.toStringAsFixed(2);
                double celsiusValue = inputValue - 273.15;
                celsiusController.text = celsiusValue.toStringAsFixed(2);
                reamur = celsiusValue * 0.8;
                reamurController.text = reamur.toStringAsFixed(2);
              },
            ),
            SizedBox(height: 20),
            Text(
              'Conversion Results:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '$kelvin K',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            TextField(
              controller: reamurController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Reamur',
                suffixText: '°Re',
              ),
              onChanged: (value) {
                double inputValue = double.tryParse(value) ?? 0;
                double fahrenheitValue = (inputValue * 9 / 4) + 32;
                fahrenheitController.text = fahrenheitValue.toStringAsFixed(2);
                double celsiusValue = inputValue * 5 / 4;
                celsiusController.text = celsiusValue.toStringAsFixed(2);
                kelvin = celsiusValue + 273.15;
                kelvinController.text = kelvin.toStringAsFixed(2);
              },
            ),
            SizedBox(height: 20),
            Text(
              'Conversion Results:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '$reamur °Re',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: clearFields,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade900,
                minimumSize: Size(double.infinity, 40),
              ),
              child: Text('Clear', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: KonversiSuhu(),
  ));
}
