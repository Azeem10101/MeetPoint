import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text_field.dart';

class MeetupFormCard extends StatelessWidget {
  final TextEditingController firstLocationController;
  final TextEditingController secondLocationController;
  final VoidCallback onGetStarted;
  final bool isLoading;

  const MeetupFormCard({
    super.key,
    required this.firstLocationController,
    required this.secondLocationController,
    required this.onGetStarted,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          AppTextField(
            hintText: 'Enter first location',
            controller: firstLocationController,
            enabled: !isLoading,
          ),

          const SizedBox(height: 16),

          AppTextField(
            hintText: 'Enter second location',
            controller: secondLocationController,
            enabled: !isLoading,
          ),

          const SizedBox(height: 24),

          AppButton(
            text: isLoading ? 'Loading...' : 'Get Started',
            onPressed: isLoading ? () {} : onGetStarted,
          ),
        ],
      ),
    );
  }
}