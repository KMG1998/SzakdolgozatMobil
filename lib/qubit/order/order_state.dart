part of 'order_cubit.dart';

@immutable
class OrderState {
  final Order? currentOrder;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;

  const OrderState({
    this.currentOrder,
    required this.isLoading,
    required this.hasError,
    this.errorMessage,
  });

  OrderState copyWith({currentOrder, isLoading, hasError, errorMessage}) {
    return OrderState(
      currentOrder: currentOrder,
      isLoading: isLoading,
      hasError: hasError,
      errorMessage: errorMessage,
    );
  }
}
