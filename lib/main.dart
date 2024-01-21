import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:notes_app/views/homeScreen.dart';
import 'package:notes_app/views/splashScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold)),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.black54,
            textColor: Colors.black87,
            style: ListTileStyle.drawer,
          ),
          useMaterial3: true,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.black,
              iconSize: 30)),
      home: const SplashScreen(),
    );
  }
}
