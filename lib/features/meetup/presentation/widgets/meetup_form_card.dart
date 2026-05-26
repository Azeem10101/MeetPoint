import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../logic/participant_input_state.dart';

typedef ParticipantLocationChanged = void Function({
  required String inputId,
  required String locationText,
});

class MeetupFormCard extends StatelessWidget {
  final List<ParticipantInputState> participantInputs;
  final ParticipantLocationChanged onLocationChanged;
  final VoidCallback onAddParticipant;
  final ValueChanged<String> onRemoveParticipant;
  final VoidCallback onGetStarted;
  final bool isLoading;
  final bool canRemoveParticipants;

  const MeetupFormCard({
    super.key,
    required this.participantInputs,
    required this.onLocationChanged,
    required this.onAddParticipant,
    required this.onRemoveParticipant,
    required this.onGetStarted,
    required this.isLoading,
    required this.canRemoveParticipants,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          for (final input in participantInputs) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppTextField(
                    key: ValueKey(input.id),
                    hintText: 'Enter location',
                    initialValue: input.locationText,
                    enabled: !isLoading,
                    onChanged: (locationText) {
                      onLocationChanged(
                        inputId: input.id,
                        locationText: locationText,
                      );
                    },
                  ),
                ),

                const SizedBox(width: 8),

                IconButton(
                  tooltip: 'Remove participant',
                  onPressed: canRemoveParticipants && !isLoading
                      ? () {
                          onRemoveParticipant(input.id);
                        }
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
              ],
            ),

            const SizedBox(height: 16),
          ],

          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: isLoading ? null : onAddParticipant,
              icon: const Icon(Icons.add),
              label: const Text('Add participant'),
            ),
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
