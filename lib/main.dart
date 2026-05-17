import 'package:flutter/material.dart';
import 'features/meetup/presentation/screens/home_screen.dart';

void main() {
  runApp(const MeetPointApp());
}

class MeetPointApp extends StatelessWidget {
  const MeetPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MeetPoint',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}