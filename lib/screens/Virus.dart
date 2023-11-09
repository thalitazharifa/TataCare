import 'package:flutter/material.dart';
import 'TentangVirus.dart';

class Virus extends StatefulWidget {
  @override
  _VirusState createState() => _VirusState();
}

class _VirusState extends State<Virus> {
  TextEditingController virusNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virus Information'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                height: 300
                ,
                child: Image.asset('assets/images/v1.png'),
              ),
              SizedBox(height: 20),
              Text(
                'Enter Virus Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: virusNameController,
                decoration: InputDecoration(
                  labelText: 'Virus Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TentangVirus(virusName: virusNameController.text),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade900,
                  ),
                  child: Text('Explore Virus'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
