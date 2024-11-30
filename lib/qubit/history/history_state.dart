import 'package:szakdolgozat_magantaxi_mobil/models/Order.dart';

class HistoryState {}

class HistoryInit extends HistoryState {}
class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  List<Order> orders;
  String? errorMessage;
  HistoryLoaded({required this.orders, this.errorMessage});
}
