import '../models/location_model.dart';

class MeetupService {
  static LocationModel calculateMidpoint({
    required LocationModel firstLocation,
    required LocationModel secondLocation,
  }) {
    final midpointLatitude =
        (firstLocation.latitude + secondLocation.latitude) / 2;

    final midpointLongitude =
        (firstLocation.longitude + secondLocation.longitude) / 2;

    return LocationModel(
      name: 'Calculated Midpoint',
      latitude: midpointLatitude,
      longitude: midpointLongitude,
    );
  }
}