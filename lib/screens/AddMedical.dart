import 'package:flutter/material.dart';
import '../global/Database.dart';
import '../global/toast.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  uploadData() async {
    Map<String, dynamic> uploaddata = {
      "Patient Name": patientController.text,
      "Medical History": medicalController.text,
      "Patient Age": userageController.text,
    };
    await DatabaseMethods().addUserDetails(uploaddata);
    showUpload(message: 'Uploaded Successfully');
  }

  TextEditingController patientController = TextEditingController();
  TextEditingController medicalController = TextEditingController();
  TextEditingController userageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Add Patient Medical Data',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: patientController,
              decoration: InputDecoration(
                labelText: 'Patient Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: medicalController,
              decoration: InputDecoration(
                labelText: 'Medical History',
                prefixIcon: Icon(Icons.assignment),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: userageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Patient Age',
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                uploadData();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Add Data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
