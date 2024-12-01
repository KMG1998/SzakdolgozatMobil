class Order {
  final String id;
  final String startAddress;
  final String destinationAddress;
  final String startDateTime;
  final String finishDateTime;
  final int price;
  final int closureType;

  Order(
      {required this.id,
      required this.startAddress,
      required this.destinationAddress,
      required this.startDateTime,
      required this.finishDateTime,
      required this.price,
      required this.closureType});

  Order.fromJson(Map<String, dynamic> json)
      : id = json["id"] as String,
        startAddress = json["startAddress"] as String,
        destinationAddress = json["destinationAddress"] as String,
        startDateTime = json["startDateTime"] as String,
        finishDateTime = json["finishDateTime"] as String,
        price = json["price"] as int,
        closureType = json["closureType"] as int;
}
