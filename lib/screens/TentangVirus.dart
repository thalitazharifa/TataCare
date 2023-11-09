import 'package:flutter/material.dart';

class TentangVirus extends StatelessWidget {
  final String virusName;

  TentangVirus({required this.virusName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Virus'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/nodata.png',
                height: 150,
                width: 150,
              ),
              SizedBox(height: 20),
              Text(
                'Virus: $virusName',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Sorry, we don't have any information about the virus.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade900,
                  ),
                  child: Text('Back'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
