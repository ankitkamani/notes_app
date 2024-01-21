import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/views/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Get.off(MyHomePage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: SizedBox.square(
                dimension: 200,
                child: Image.asset('assets/Notes.png'),
              ),
            ),
          ),
          const Text("Powered By Ankit Kamani",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
