import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/app_text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

            AppCard(
              child: Column(
                children: [
                  const AppTextField(
                    hintText: 'Enter first location',
                  ),

                  const SizedBox(height: 16),

                  const AppTextField(
                    hintText: 'Enter second location',
                  ),

                  const SizedBox(height: 24),

                  AppButton(
                    text: 'Get Started',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}