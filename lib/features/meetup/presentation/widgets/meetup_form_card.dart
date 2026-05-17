import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text_field.dart';

class MeetupFormCard extends StatelessWidget {
  const MeetupFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
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
    );
  }
}