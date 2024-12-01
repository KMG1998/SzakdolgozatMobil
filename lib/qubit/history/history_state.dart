import 'package:szakdolgozat_magantaxi_mobil/models/order.dart';

class HistoryState {}

class HistoryInit extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  List<Order> orders;
  int? selectedOrderIndex;
  String? errorMessage;

  HistoryLoaded({required this.orders, this.selectedOrderIndex, this.errorMessage});

  HistoryLoaded copyWith({List<Order>? orders, int? selectedOrderIndex, String? errorMessage}) {
    return HistoryLoaded(
        orders: orders ?? this.orders,
        selectedOrderIndex: selectedOrderIndex ?? this.selectedOrderIndex,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
