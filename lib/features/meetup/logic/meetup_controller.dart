import 'package:flutter/foundation.dart';

import '../domain/models/meetup_plan.dart';
import '../domain/models/participant.dart';
import 'meetup_state.dart';
import 'participant_input_state.dart';

class MeetupController extends ChangeNotifier {
  static const int minimumParticipantCount = 2;

  MeetupState _state;
  int _nextInputId;

  MeetupController({
    MeetupState? initialState,
  })  : _state = initialState ?? MeetupState.initial(),
        _nextInputId =
            (initialState?.participantInputs.length ?? minimumParticipantCount) +
                1;

  MeetupState get state => _state;

  void addParticipantInput() {
    final input = ParticipantInputState(
      id: 'participant-input-$_nextInputId',
    );
    _nextInputId += 1;

    _setState(
      _state.copyWith(
        participantInputs: [
          ..._state.participantInputs,
          input,
        ],
        clearPlan: true,
        clearError: true,
      ),
    );
  }

  void updateParticipantLocationText({
    required String inputId,
    required String locationText,
  }) {
    _setState(
      _state.copyWith(
        participantInputs: _state.participantInputs.map((input) {
          if (input.id != inputId) {
            return input;
          }

          return input.copyWith(locationText: locationText);
        }).toList(),
        clearPlan: true,
        clearError: true,
      ),
    );
  }

  void removeParticipantInput(String inputId) {
    if (_state.participantInputs.length <= minimumParticipantCount) {
      return;
    }

    _setState(
      _state.copyWith(
        participantInputs: _state.participantInputs
            .where((input) => input.id != inputId)
            .toList(),
        clearPlan: true,
        clearError: true,
      ),
    );
  }

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
