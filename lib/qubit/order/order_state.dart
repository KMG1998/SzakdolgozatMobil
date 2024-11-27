part of 'order_cubit.dart';

@immutable
class OrderState {}

class OrderInit extends OrderState{}

class OrderLoading extends OrderState {}

class OrderError extends OrderState {
  final String errorMessage;

  OrderError({required this.errorMessage});
}

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
