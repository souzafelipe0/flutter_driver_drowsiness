import 'package:flutter/material.dart';
import 'package:flutter_driver_drowsiness/screens/main_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Driver Drowsiness Validation',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black), useMaterial3: true),
      home: const MainPages(),
    );
  }
}
