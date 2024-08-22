class PlaceModel {
  final String formattedAddress;
  final Location location;
  final DisplayName displayName;

  PlaceModel({
    required this.formattedAddress,
    required this.location,
    required this.displayName,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      formattedAddress: json['formattedAddress'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      displayName: DisplayName.fromJson(json['displayName'] ?? {}),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
    );
  }
}

class DisplayName {
  final String text;
  final String languageCode;

  DisplayName({
    required this.text,
    required this.languageCode,
  });

  factory DisplayName.fromJson(Map<String, dynamic> json) {
    return DisplayName(
      text: json['text'] ?? '',
      languageCode: json['languageCode'] ?? 'en',
    );
  }
}
