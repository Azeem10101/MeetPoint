import 'participant.dart';
import 'place.dart';

class MeetupPlan {
  final List<Participant> participants;
  final Place? suggestedPlace;

  const MeetupPlan({
    required this.participants,
    this.suggestedPlace,
  });

  bool get hasSuggestion => suggestedPlace != null;

  MeetupPlan copyWith({
    List<Participant>? participants,
    Place? suggestedPlace,
    bool clearSuggestedPlace = false,
  }) {
    return MeetupPlan(
      participants: List.unmodifiable(
        participants ?? this.participants,
      ),
      suggestedPlace: clearSuggestedPlace
          ? null
          : suggestedPlace ?? this.suggestedPlace,
    );
  }
}
