import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'Home.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> with SingleTickerProviderStateMixin {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool position = false;
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  void animator() async {
    if (opacity == 0) {
      opacity = 1;
      position = true;
    } else {
      opacity = 0;
      position = false;
    }

    setState(() {});
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Registration Successful",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Account created successfully.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 60.0 : 150.0,
              left: 20.0,
              right: 20.0,
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(milliseconds: 400),
                      child: Text("Register", style: TextStyle(fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 5)),
                    ),
                    // Image below "Register" text
                    Image.asset("assets/images/register.png", width: 180, height: 180),

                    // Input fields for registration
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(milliseconds: 400),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: "Full Name",
                              ),
                            ),
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                              ),
                            ),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: "Password",
                              ),
                              obscureText: true, // Sembunyikan kata sandi
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Checkbox for terms and conditions
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Checkbox(value: false, onChanged: (bool? value) {

                          }),
                          Text("I accept terms and conditions"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // "Register" button
                    AnimatedPositioned(
                      bottom: 60.0,
                      left: 20.0,
                      right: 20.0,
                      duration: const Duration(milliseconds: 400),
                      child: AnimatedOpacity(
                        opacity: opacity,
                        duration: const Duration(milliseconds: 400),
                        child: GestureDetector(
                          onTap: _signUp,
                          child: Container(
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text("Register", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Kembali ke halaman Login
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          InkWell(
                            onTap: () {
                              // Navigasi kembali ke halaman Login saat "Login" ditekan
                              Navigator.pop(context);
                            },
                            child: Text(" Login"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _signUp() async {
    String? username = _usernameController.text;
    String? email = _emailController.text;
    String? password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print('Register successfully created');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      print('Sign up failed');
    }
  }
}
