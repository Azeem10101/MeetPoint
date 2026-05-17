import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_text.dart';
import '../widgets/meetup_form_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController firstLocationController =
    TextEditingController();

  final TextEditingController secondLocationController =
    TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MeetPoint'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const AppText(
              text: 'Find the Perfect Meetup Point',
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 12),

            const AppText(
              text:
                  'MeetPoint helps groups discover the most convenient location to meet.',
              fontSize: 16,
            ),

            const SizedBox(height: 32),

            MeetupFormCard(
              firstLocationController: firstLocationController,
              secondLocationController: secondLocationController,
            ),
          ],
        ),
      ),
    );
  }
}