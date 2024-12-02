import 'package:szakdolgozat_magantaxi_mobil/models/order_review.dart';

class ReviewListState {}

class ReviewListInit extends ReviewListState {}

class ReviewListLoading extends ReviewListState {}

class ReviewListLoaded extends ReviewListState {
  List<OrderReview> reviews;
  String? errorMessage;

  ReviewListLoaded({required this.reviews, this.errorMessage});

  ReviewListLoaded copyWith({List<OrderReview>? reviews, int? selectedOrderIndex, String? errorMessage}) {
    return ReviewListLoaded(
        reviews: reviews ?? this.reviews,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
