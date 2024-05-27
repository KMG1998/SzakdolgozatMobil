part of 'order_cubit.dart';

@immutable
class OrderState {
  final Order? currentOrder;
  final Position? currentPassengerPos;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final List<PointLatLng>? currentRoute;

  const OrderState({
    this.currentOrder,
    required this.isLoading,
    required this.hasError,
    this.errorMessage,
    this.currentRoute,
    this.currentPassengerPos,
  });

  OrderState copyWith({currentOrder, isLoading, hasError, errorMessage, currentRoute, currentPassengerPos}) {
    return OrderState(
      currentOrder: currentOrder ?? this.currentOrder,
      isLoading: isLoading  ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      currentRoute: currentRoute ?? this.currentRoute,
      currentPassengerPos: currentPassengerPos ?? this.currentPassengerPos,
    );
  }
}
