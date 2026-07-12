import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const PinyinApp());
}

class PinyinApp extends StatelessWidget {
  const PinyinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '拼音学习',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          primary: Colors.orange,
          secondary: Colors.lightBlue,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // We can change this to a kid-friendly font later
      ),
      home: const HomePage(),
    );
  }
}
