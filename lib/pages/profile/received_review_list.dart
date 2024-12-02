import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/reviewList/review_list_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/reviewList/review_list_state.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/app_decoration.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/theme_helper.dart';

class ReceivedReviewList extends StatefulWidget {
  const ReceivedReviewList({super.key});

  @override
  State<ReceivedReviewList> createState() => _ReceivedReviewListState();
}

class _ReceivedReviewListState extends State<ReceivedReviewList> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (a, b) => {},
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.5, 0),
                end: const Alignment(0.5, 1),
                colors: [
                  theme.colorScheme.primaryContainer,
                  appTheme.blue100,
                  theme.colorScheme.onSecondaryContainer,
                ],
              ),
            ),
            child: BlocBuilder<ReviewListCubit, ReviewListState>(
              builder: (context, state) {
                if (state is ReviewListInit) {
                  context.read<ReviewListCubit>().getReviews();
                }
                if (state is ReviewListLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ReviewListCubit>().reset();
                    },
                    color: Colors.black,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusStyle.roundedBorderTL20,
                            border: Border(
                              top: BorderSide(width: 2),
                              left: BorderSide(width: 2),
                              right: BorderSide(width: 2),
                            ),
                          ),
                          child: Text(
                            'Kapott értékeléseid',
                            style: theme.textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          height: 730.h,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusStyle.customBorderBL20,
                            border: Border.all(width: 2),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.reviews.length,
                            itemBuilder: (BuildContext context, int index) {
                              final currentReview = state.reviews[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 2),
                                  borderRadius: BorderRadiusStyle.roundedBorder20,
                                ),
                                child: ListTile(
                                  title: _createItem(currentReview.score, currentReview.reviewText),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballClipRotatePulse,
                      colors: [Colors.black],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _createItem(double score, String text) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            score.toString(),
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
