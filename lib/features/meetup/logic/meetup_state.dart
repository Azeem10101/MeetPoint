import '../domain/models/meetup_plan.dart';
import '../domain/models/participant.dart';
import 'participant_input_state.dart';

class MeetupState {
  final List<Participant> participants;
  final List<ParticipantInputState> participantInputs;
  final MeetupPlan? plan;
  final bool isLoading;
  final String? errorMessage;

  const MeetupState({
    required this.participants,
    required this.participantInputs,
    this.plan,
    this.isLoading = false,
    this.errorMessage,
  });

  factory MeetupState.initial() {
    return const MeetupState(
      participants: [],
      participantInputs: [
        ParticipantInputState(id: 'participant-input-1'),
        ParticipantInputState(id: 'participant-input-2'),
      ],
    );
  }

  bool get canCreatePlan {
    return participantInputs.length >= 2 &&
        participantInputs.every((input) => input.hasLocationText);
  }

  MeetupState copyWith({
    List<Participant>? participants,
    List<ParticipantInputState>? participantInputs,
    MeetupPlan? plan,
    bool? isLoading,
    String? errorMessage,
    bool clearPlan = false,
    bool clearError = false,
  }) {
    return MeetupState(
      participants: List.unmodifiable(
        participants ?? this.participants,
      ),
      participantInputs: List.unmodifiable(
        participantInputs ?? this.participantInputs,
      ),
      plan: clearPlan ? null : plan ?? this.plan,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
