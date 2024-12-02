part of 'order_cubit.dart';

@immutable
class OrderState {}

class OrderInit extends OrderState{
  final String? error;

  OrderInit({this.error});
}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final VehicleData vehicleData;
  final Position currentPassengerPos;
  final List<PointLatLng> currentRoute;

  OrderLoaded({
    required this.currentPassengerPos,
    required this.currentRoute,
    required this.vehicleData,
  });
}
