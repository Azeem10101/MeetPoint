import '../domain/models/meetup_plan.dart';
import '../domain/models/participant.dart';

class MeetupState {
  final List<Participant> participants;
  final MeetupPlan? plan;
  final bool isLoading;
  final String? errorMessage;

  const MeetupState({
    required this.participants,
    this.plan,
    this.isLoading = false,
    this.errorMessage,
  });

  factory MeetupState.initial() {
    return const MeetupState(
      participants: [],
    );
  }

  bool get canCreatePlan {
    return participants.length >= 2 &&
        participants.every((participant) => participant.hasOrigin);
  }

  MeetupState copyWith({
    List<Participant>? participants,
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
      plan: clearPlan ? null : plan ?? this.plan,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
