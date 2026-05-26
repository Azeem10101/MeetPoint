import '../constants/mock_locations.dart';
import '../models/location_model.dart';

class MeetupService {
  static LocationModel? getLocationCoordinates(String locationName) {
    final normalizedLocation =
      locationName
        .trim()
        .toLowerCase();

final resolvedLocation =
    locationAliases[
        normalizedLocation
    ] ??
    normalizedLocation;

    final locationData =
        mockLocations[resolvedLocation];

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

  static LocationModel calculateGroupMidpoint(
    List<LocationModel> locations,
  ) {
    final totalLatitude = locations.fold<double>(
      0,
      (total, location) => total + location.latitude,
    );

    final totalLongitude = locations.fold<double>(
      0,
      (total, location) => total + location.longitude,
    );

    return LocationModel(
      name: 'Calculated Midpoint',
      latitude: totalLatitude / locations.length,
      longitude: totalLongitude / locations.length,
    );
  }
}
