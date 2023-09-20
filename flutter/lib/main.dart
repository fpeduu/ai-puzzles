import 'package:flutter/material.dart';
import 'pages/landing.dart';
import 'pages/input.dart';
import 'pages/puzzle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Puzzle App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Color(0xFF343434),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 36.0, color: Color(0xFFF8F1FF)),
          headline2: TextStyle(fontSize: 20.0, color: Color(0xFFF8F1FF)),
          // ... (other text styles)
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/input': (context) => InputPage(),
        '/puzzle': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return PuzzlePage(input: args['input']!);
        },
      },
    );
  }
const MyApp({super.key});
}
