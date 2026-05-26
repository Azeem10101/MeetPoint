import 'package:flutter/foundation.dart';

import '../domain/models/meetup_plan.dart';
import '../domain/models/participant.dart';
import 'meetup_state.dart';

class MeetupController extends ChangeNotifier {
  MeetupState _state;

  MeetupController({
    MeetupState? initialState,
  }) : _state = initialState ?? MeetupState.initial();

  MeetupState get state => _state;

  void setParticipants(List<Participant> participants) {
    _setState(
      _state.copyWith(
        participants: participants,
        clearPlan: true,
        clearError: true,
      ),
    );
  }

  void addParticipant(Participant participant) {
    _setState(
      _state.copyWith(
        participants: [
          ..._state.participants,
          participant,
        ],
        clearPlan: true,
        clearError: true,
      ),
    );
  }

  void updateParticipant(Participant updatedParticipant) {
    _setState(
      _state.copyWith(
        participants: _state.participants.map((participant) {
          if (participant.id != updatedParticipant.id) {
            return participant;
          }

          return updatedParticipant;
        }).toList(),
        clearPlan: true,
        clearError: true,
      ),
    );
  }

  void removeParticipant(String participantId) {
    _setState(
      _state.copyWith(
        participants: _state.participants
            .where((participant) => participant.id != participantId)
            .toList(),
        clearPlan: true,
        clearError: true,
      ),
    );
  }

  void setLoading(bool isLoading) {
    _setState(
      _state.copyWith(
        isLoading: isLoading,
        clearError: true,
      ),
    );
  }

  void setError(String message) {
    _setState(
      _state.copyWith(
        isLoading: false,
        errorMessage: message,
      ),
    );
  }

  void setPlan(MeetupPlan plan) {
    _setState(
      _state.copyWith(
        plan: plan,
        isLoading: false,
        clearError: true,
      ),
    );
  }

  void clearPlan() {
    _setState(
      _state.copyWith(
        clearPlan: true,
      ),
    );
  }

  void _setState(MeetupState state) {
    _state = state;
    notifyListeners();
  }
}
