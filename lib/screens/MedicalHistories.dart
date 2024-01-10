import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/database.dart';
import '../global/toast.dart';
import 'AddMedical.dart';

class Medical extends StatefulWidget {
  const Medical({Key? key}) : super(key: key);

  @override
  State<Medical> createState() => _MedicalState();
}

class _MedicalState extends State<Medical> {
  String? patient, medicalhistory, age, id;

  TextEditingController patientController = TextEditingController();
  TextEditingController medicalController = TextEditingController();

  searchUser(String name) async {
    QuerySnapshot querySnapshot = await DatabaseMethods().getthisUserInfo(name);

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        patient = "${querySnapshot.docs[0]["Patient Name"]}";
        medicalhistory = "${querySnapshot.docs[0]["Medical History"]}";
        age = "${querySnapshot.docs[0]["Patient Age"]}";
        id = querySnapshot.docs[0].id; // Set the id from the document
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Patient Medical Data"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Patient Information",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: patientController,
              decoration: InputDecoration(
                hintText: 'Enter Patient Name',
                border: OutlineInputBorder(),
                labelText: 'Patient Name',
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: medicalController,
              decoration: InputDecoration(
                hintText: 'Enter Medical History',
                border: OutlineInputBorder(),
                labelText: 'Medical History',
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    searchUser(patientController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade900,
                    minimumSize: Size(150, 50),
                  ),
                  child: Text("Search"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String newMedical = medicalController.text;
                    if (newMedical.isNotEmpty && id != null) {
                      await DatabaseMethods().UpdateUserData(newMedical, id!);
                      searchUser(patientController.text);
                      _showSnackBar('Updated Successfully!');
                    } else {
                      _showSnackBar('Please enter a valid medical history.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade900,
                    minimumSize: Size(150, 50),
                  ),
                  child: Text("Update"),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await searchUser(patientController.text);
                    if (id != null) {
                      await DatabaseMethods().DeleteUserData(id!);
                      Fluttertoast.showToast(
                        msg: "Deleted Successfully!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      _showSnackBar('Cannot delete. User not found.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade900,
                    minimumSize: Size(150, 50),
                  ),
                  child: Text("Delete"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddData(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade900,
                    minimumSize: Size(150, 50),
                  ),
                  child: Text("Add Data"),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            if (patient != null) ...[
              Text(
                "Patient Name: $patient",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (medicalhistory != null) ...[
              SizedBox(height: 10),
              Text(
                "Medical History: $medicalhistory",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (age != null) ...[
              SizedBox(height: 10),
              Text(
                "Patient Age: $age",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
