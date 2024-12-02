class OrderReview {
  final double score;
  final String reviewText;

  OrderReview({required this.score, required this.reviewText});

  OrderReview.fromJson(Map<String, dynamic> json)
      : score = json['score'] is int ? (json['score'] as int).toDouble() : json['score'],
        reviewText = json['reviewText'];

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'reviewText': reviewText,
    };
  }
}
