import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../data/models/location_model.dart';

class MeetupResultCard extends StatelessWidget {
  final LocationModel meetupLocation;

  const MeetupResultCard({
    super.key,
    required this.meetupLocation,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            text: 'Suggested Meetup Point',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),

          const SizedBox(height: 16),

          AppText(
            text: meetupLocation.name,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),

          const SizedBox(height: 8),

          AppText(
            text:
                'Latitude: ${meetupLocation.latitude.toStringAsFixed(4)}',
          ),

          AppText(
            text:
                'Longitude: ${meetupLocation.longitude.toStringAsFixed(4)}',
          ),
        ],
      ),
    );
  }
}