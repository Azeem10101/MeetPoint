class Place {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  const Place({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  Place copyWith({
    String? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
