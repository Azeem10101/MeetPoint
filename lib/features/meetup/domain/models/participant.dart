import 'place.dart';

class Participant {
  final String id;
  final String? name;
  final Place? origin;

  const Participant({
    required this.id,
    this.name,
    this.origin,
  });

  bool get hasOrigin => origin != null;

  Participant copyWith({
    String? id,
    String? name,
    Place? origin,
    bool clearName = false,
    bool clearOrigin = false,
  }) {
    return Participant(
      id: id ?? this.id,
      name: clearName ? null : name ?? this.name,
      origin: clearOrigin ? null : origin ?? this.origin,
    );
  }
}
