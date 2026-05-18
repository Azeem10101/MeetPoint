import '../constants/mock_locations.dart';
import '../models/location_model.dart';

class MeetupService {
  static LocationModel? getLocationCoordinates(String locationName) {
    final normalizedLocation =
        locationName.trim().toLowerCase();

    final locationData =
        mockLocations[normalizedLocation];

    if (locationData == null) {
      return null;
    }

    return LocationModel(
      name: locationName,
      latitude: locationData['lat']!,
      longitude: locationData['lng']!,
    );
  }

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