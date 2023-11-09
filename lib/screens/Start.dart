import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hospital/screens/Login.dart';
import 'package:hospital/widgets/text_widget.dart';

class Startpage extends StatefulWidget {
  const Startpage({Key? key}) : super(key: key);

  @override
  _StartpageState createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> with SingleTickerProviderStateMixin {
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
                      child: TextWidget("TataCare", 35, Colors.black, FontWeight.bold, letterSpace: 5),
                    ),
                    const SizedBox(height: 5),
                    AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(milliseconds: 400),
                      child: TextWidget("Multi-Function Application", 18, Colors.black, FontWeight.bold, letterSpace: 1),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(milliseconds: 400),
                      child: TextWidget("Early Protection for Family Health", 15, Colors.black.withOpacity(.5), FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            // Gambar "tatacare.png" di tengah-tengah layar
            Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: Container(
                  height: 350,
                  width: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/tatacare.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: (MediaQuery.of(context).size.width - 150) / 2, // Menempatkannya di tengah secara horizontal
              bottom: 60,
              child: InkWell(
                onTap: () {
                  position = false;
                  opacity = 0;
                  setState(() {});
                  Timer(const Duration(milliseconds: 400), () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
                  });
                },
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 400),
                  child: Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: TextWidget("Get Started", 17, Colors.white, FontWeight.bold, letterSpace: 0),
                    ),
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
