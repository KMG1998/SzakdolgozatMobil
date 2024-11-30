class VehicleData {
  final String vehicleColor;
  final String vehicleType;
  final String vehiclePlate;
  final int seatCount;
  final double? reviewAvg;

  VehicleData(
      {required this.vehicleColor,
      required this.vehicleType,
      required this.vehiclePlate,
      required this.seatCount,
      required this.reviewAvg});

  VehicleData.fromJson(Map<String, dynamic> json)
      : vehicleColor = json['vehicleColor'],
        vehiclePlate = json['vehiclePlate'] as String,
        vehicleType = json['vehicleType'] as String,
        seatCount = json['seatCount'] as int,
        reviewAvg = json['reviewAvg'] is int
            ? (json['reviewAvg'] as int).toDouble()
            : json['reviewAvg'] as double?;

  Map<String, dynamic> toJson() => {
        'vehicleColor': vehicleColor,
        'vehicleType': vehicleType,
        'vehiclePlate': vehiclePlate,
        'seatCount': seatCount,
        'reviewAvg': reviewAvg,
      };
}
