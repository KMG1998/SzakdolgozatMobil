class DriverLocation {
  final String UUID;
  final double latitude;
  final double longitude;

  DriverLocation({
    required this.UUID,
    required this.latitude,
    required this.longitude,
  });

  factory DriverLocation.fromJson(Map<String, dynamic> json) {
    return DriverLocation(
        UUID: json["UUID"],
        latitude: json["lat"],
        longitude: json['long']);
  }
}
