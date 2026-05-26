import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_text.dart';
import '../../data/models/location_model.dart';
import '../../data/services/meetup_service.dart';
import '../../logic/meetup_controller.dart';
import '../widgets/meetup_form_card.dart';
import '../widgets/meetup_result_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final MeetupController meetupController;

  LocationModel? meetupResult;

  @override
  void initState() {
    super.initState();

    meetupController = MeetupController();
  }

  Future<void> handleGetStarted() async {
    final locationTexts = meetupController.state.participantInputs
        .map((input) => input.locationText.trim())
        .toList();

    if (locationTexts.any((locationText) => locationText.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all locations'),
        ),
      );

      return;
    }

    meetupController.setLoading(true);

    setState(() {
      meetupResult = null;
    });

    await Future.delayed(const Duration(seconds: 2));

    final resolvedLocations = locationTexts
        .map(MeetupService.getLocationCoordinates)
        .toList();

    if (resolvedLocations.any((location) => location == null)) {
      if (!mounted) return;

      meetupController.setLoading(false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'One or both locations are not supported yet',
          ),
        ),
      );

      return;
    }

    final calculatedMeetup = MeetupService.calculateGroupMidpoint(
      resolvedLocations.cast<LocationModel>(),
    );

    if (!mounted) return;

    meetupController.setLoading(false);

    setState(() {
      meetupResult = calculatedMeetup;
    });
  }

  @override
  void dispose() {
    meetupController.dispose();

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

            AnimatedBuilder(
              animation: meetupController,
              builder: (context, child) {
                final state = meetupController.state;

                return MeetupFormCard(
                  participantInputs: state.participantInputs,
                  onLocationChanged:
                      meetupController.updateParticipantLocationText,
                  onAddParticipant:
                      meetupController.addParticipantInput,
                  onRemoveParticipant:
                      meetupController.removeParticipantInput,
                  onGetStarted: handleGetStarted,
                  isLoading: state.isLoading,
                  canRemoveParticipants: state.participantInputs.length >
                      MeetupController.minimumParticipantCount,
                );
              },
            ),

            AnimatedBuilder(
              animation: meetupController,
              builder: (context, child) {
                if (!meetupController.state.isLoading) {
                  return const SizedBox.shrink();
                }

                return const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    'Loading new meetup result...',
                  ),
                );
              },
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
