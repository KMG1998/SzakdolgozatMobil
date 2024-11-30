import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/history/history_state.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/order_service.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super((HistoryInit()));
  final _logger = Logger();
  void getHistory() async{
    emit(HistoryLoading());
    _logger.d('before request');
    final history = await getIt.get<OrderService>().getHistory();
    if(history != null){
      emit(HistoryLoaded(orders: history));
      return;
    }
    emit(HistoryLoaded(orders: [],errorMessage: 'Ismeretlen hiba'));
  }

  void reset(){
    emit(HistoryInit());
  }
}
