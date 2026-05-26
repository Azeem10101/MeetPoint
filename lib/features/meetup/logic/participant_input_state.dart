class ParticipantInputState {
  final String id;
  final String locationText;

  const ParticipantInputState({
    required this.id,
    this.locationText = '',
  });

  bool get hasLocationText => locationText.trim().isNotEmpty;

  ParticipantInputState copyWith({
    String? id,
    String? locationText,
  }) {
    return ParticipantInputState(
      id: id ?? this.id,
      locationText: locationText ?? this.locationText,
    );
  }
}
