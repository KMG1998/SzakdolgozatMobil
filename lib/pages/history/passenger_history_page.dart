import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/history/history_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/history/history_state.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_nav_bar.dart';

class PassengerHistoryPage extends StatefulWidget {
  const PassengerHistoryPage({super.key});

  @override
  State<PassengerHistoryPage> createState() => _PassengerHistoryPageState();
}

class _PassengerHistoryPageState extends State<PassengerHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
            child: BlocBuilder<HistoryCubit, HistoryState>(
              builder: (context, state) {
                if (state is HistoryInit) {
                  context.read<HistoryCubit>().getHistory();
                }
                if (state is HistoryLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<HistoryCubit>().reset();
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
                            'Korábbi foglalások',
                            style: theme.textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          height: 750.h,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusStyle.customBorderBL20,
                            border: Border.all(width: 2),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 2),
                                  borderRadius: BorderRadiusStyle.roundedBorder20,
                                ),
                                child: ListTile(
                                  title: Text(
                                    DateFormat('yyyy-MM-dd – HH:mm:ss')
                                        .format(DateTime.parse(state.orders[index].finishDateTime)),
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.arrow_right_alt),
                                    onPressed: () {
                                      context.read<HistoryCubit>().selectOrder(index);
                                      Navigator.pushNamed(context, AppRoutes.historyOrderDetailsPage);
                                    },
                                  ),
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
          bottomNavigationBar: CustomNavBar(activeNum: 0),
        ),
      ),
    );
  }
}
