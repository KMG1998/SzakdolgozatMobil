class Order {
  final String id;
  final String customerId;
  final String driverId;
  final String vehicleId;
  final String startAddress;
  final String destinationAddress;
  final String startDateTime;
  final String finishDateTime;
  final bool isImmediate;
  final int price;
  final String creationDateTime;
  int? closureType;

  Order({
    required this.id,
    required this.customerId,
    required this.driverId,
    required this.vehicleId,
    required this.startAddress,
    required this.destinationAddress,
    required this.startDateTime,
    required this.finishDateTime,
    required this.isImmediate,
    required this.price,
    required this.creationDateTime,
    this.closureType
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json["id"],
        customerId:json["customerId"],
        driverId:json["driverId"],
        vehicleId:json["vehicleId"],
        startAddress:json["startAddress"],
        destinationAddress:json["destinationAddress"],
        startDateTime:json["startDateTime"],
        finishDateTime:json["finishDateTime"],
        isImmediate:json["isImmediate"],
        price:json["price"],
        creationDateTime:json["creationDateTime"],
        closureType:json["closureType"],
    );
  }
}
