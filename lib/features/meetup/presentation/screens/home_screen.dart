import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_text.dart';
import '../../data/models/location_model.dart';
import '../../data/services/meetup_service.dart';
import '../widgets/meetup_form_card.dart';
import '../widgets/meetup_result_card.dart';

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

  bool isLoading = false;

  LocationModel? meetupResult;

  Future<void> handleGetStarted() async {
    final firstLocation = firstLocationController.text.trim();
    final secondLocation = secondLocationController.text.trim();

    if (firstLocation.isEmpty || secondLocation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both locations'),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    final firstMockLocation = LocationModel(
      name: firstLocation,
      latitude: 17.3850,
      longitude: 78.4867,
    );

    final secondMockLocation = LocationModel(
      name: secondLocation,
      latitude: 17.4474,
      longitude: 78.3762,
    );

    final calculatedMeetup = MeetupService.calculateMidpoint(
      firstLocation: firstMockLocation,
      secondLocation: secondMockLocation,
    );

    debugPrint('First Location: $firstLocation');
    debugPrint('Second Location: $secondLocation');

    if (!mounted) return;

    setState(() {
      meetupResult = calculatedMeetup;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    firstLocationController.dispose();
    secondLocationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MeetPoint'),
      ),
      body: SingleChildScrollView(
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
              onGetStarted: handleGetStarted,
              isLoading: isLoading,
            ),

            if (meetupResult != null) ...[
              const SizedBox(height: 24),

              MeetupResultCard(
                meetupLocation: meetupResult!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}