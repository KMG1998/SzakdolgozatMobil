import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/history/history_state.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/order_service.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super((HistoryInit()));

  void getHistory() async {
    try {
      emit(HistoryLoading());
      final history = await getIt.get<OrderService>().getHistory();
      if (history != null) {
        emit(HistoryLoaded(orders: history));
        return;
      }
      emit(HistoryLoaded(orders: [], errorMessage: 'Ismeretlen hiba'));
    } catch (e) {
      if (e is DioException) {
        emit(HistoryLoaded(orders: [], errorMessage: e.message));
        return;
      }
      emit(HistoryLoaded(orders: [], errorMessage: 'Ismeretlen hiba'));
    }
  }

  void reset() {
    emit(HistoryInit());
  }

  void selectOrder(int index) {
    emit((state as HistoryLoaded).copyWith(selectedOrderIndex: index));
  }
}
