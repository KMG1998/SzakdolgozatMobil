import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/reviewList/review_list_state.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/review_service.dart';

class ReviewListCubit extends Cubit<ReviewListState> {
  ReviewListCubit() : super((ReviewListInit()));

  void getReviews() async {
    try {
      emit(ReviewListLoading());
      final reviewList = await getIt.get<ReviewService>().getReceivedReviews();
      if (reviewList != null) {
        emit(ReviewListLoaded(reviews: reviewList));
        return;
      }
      emit(ReviewListLoaded(reviews: [], errorMessage: 'Ismeretlen hiba'));
    } catch (e) {
      if (e is DioException) {
        emit(ReviewListLoaded(reviews: [], errorMessage: e.message));
        return;
      }
      emit(ReviewListLoaded(reviews: [], errorMessage: 'Ismeretlen hiba'));
    }
  }

  void reset() {
    emit(ReviewListInit());
  }
}
