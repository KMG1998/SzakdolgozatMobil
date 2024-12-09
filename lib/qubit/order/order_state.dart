part of 'order_cubit.dart';

@immutable
class OrderState {}

class OrderInit extends OrderState {}

class OrderWaiting extends OrderState{
  final String? error;

  OrderWaiting({this.error});
}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final VehicleData vehicleData;
  final Position currentPassengerPos;
  final List<PointLatLng> currentRoute;
  final int price;
  final bool passengerPickedUp;

  OrderLoaded({
    required this.currentPassengerPos,
    required this.currentRoute,
    required this.vehicleData,
    required this.passengerPickedUp,
    required this.price,
  });

  OrderLoaded copyWith({
    VehicleData? vehicleData,
    Position? currentPassengerPos,
    List<PointLatLng>? currentRoute,
    bool? passengerPickedUp,
    int? price
  }) {
    return OrderLoaded(
      currentPassengerPos: currentPassengerPos ?? this.currentPassengerPos,
      currentRoute: currentRoute ?? this.currentRoute,
      vehicleData: vehicleData ?? this.vehicleData,
      passengerPickedUp: passengerPickedUp ?? this.passengerPickedUp,
      price: price ?? this.price,
    );
  }
}
