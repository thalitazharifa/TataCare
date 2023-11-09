import 'package:flutter/material.dart';
import 'package:hospital/screens/home.dart';
import 'package:hospital/screens/Register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
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
              top: position ? 60 : 150,
              left: 20,
              right: 20,
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
                      child: Text("Login", style: TextStyle(fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 5)),
                    ),
                    Image.asset("assets/images/login.png", width: 200, height: 200),

                    // Input fields for username and password
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(milliseconds: 400),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Username",
                              ),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Password",
                              ),
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (value) {
                            }),
                            Text("Remember Me"),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                          },
                          child: Text("Forgot Password?"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Tombol "Login" untuk menavigasi ke halaman Home
                    AnimatedPositioned(
                      bottom: 60,
                      left: 20,
                      right: 20,
                      duration: const Duration(milliseconds: 400),
                      child: AnimatedOpacity(
                        opacity: opacity,
                        duration: const Duration(milliseconds: 400),
                        child: InkWell(
                          onTap: () {
                            // Navigasi ke halaman Home saat tombol "Login" ditekan
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
                          },
                          child: Container(
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text("Login", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Melakukan navigasi ke halaman Register saat "Register Now" ditekan
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          InkWell(
                            onTap: () {
                              // Navigasi ke halaman Register saat "Register Now" ditekan
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));
                            },
                            child: Text(" Register Now"),
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
}
