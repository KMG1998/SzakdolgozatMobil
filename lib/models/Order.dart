import 'package:logger/logger.dart';

class Order {
  final String id;
  final String customerId;
  final String driverId;
  final String startAddress;
  final String destinationAddress;
  final String startDateTime;
  final String finishDateTime;
  final int price;
  int? closureType;

  static final _logger= Logger();

  Order(
      {required this.id,
      required this.customerId,
      required this.driverId,
      required this.startAddress,
      required this.destinationAddress,
      required this.startDateTime,
      required this.finishDateTime,
      required this.price,
      this.closureType});

  Order.fromJson(Map<String, dynamic> json)
      : id = json["id"] as String,
        customerId = json["customerId"] as String,
        driverId = json["driverId"] as String,
        startAddress = json["startAddress"] as String,
        destinationAddress = json["destinationAddress"] as String,
        startDateTime = json["startDateTime"] as String,
        finishDateTime = json["finishDateTime"] as String,
        price = json["price"] as int,
        closureType = json["closureType"] as int;

  static List<Order> listFromJson(List<dynamic> jsonList) {
    return List<Order>.from(jsonList.map((element) {
      _logger.d(element);
      Order.fromJson(element);
    }));
  }
}
