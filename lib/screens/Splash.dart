import 'package:flutter/material.dart';
import 'package:hospital/screens/Start.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // Delay selama 2 detik sebelum menavigasi ke halaman Start
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Startpage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Ubah warna latar belakang menjadi biru
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter, // Mengubah posisi animasi ke atas
              child: Transform.scale(
                scale: 0.8, // Mengurangi ukuran animasi
                child: SpinKitFadingCube(
                  color: Colors.white, // Warna animasi
                  size: 40.0, // Ukuran animasi yang lebih kecil
                ),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/splash.png', // Ganti dengan path gambar yang sesuai
              width: 250, // Atur lebar gambar sesuai kebutuhan
              height: 250, // Atur tinggi gambar sesuai kebutuhan
            ),
          ],
        ),
      ),
    );
  }
}
