import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MeetPoint'),
      ),
      body: const Center(
        child: AppText(
          text: 'Welcome to MeetPoint',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}