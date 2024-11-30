import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:szakdolgozat_magantaxi_mobil/gen/assets.gen.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/history/history_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/history/history_state.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/theme_helper.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_nav_bar.dart';

class PassengerHistoryPage extends StatefulWidget {
  const PassengerHistoryPage({super.key});

  @override
  State<PassengerHistoryPage> createState() => _PassengerHistoryPageState();
}

class _PassengerHistoryPageState extends State<PassengerHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
          title: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Korábbi fuvarok',
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          DateFormat('yyyy-MM-dd – HH:mm:ss')
                              .format(DateTime.parse(state.orders[index].finishDateTime)),
                          style: theme.textTheme.titleMedium,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_right_alt),
                          onPressed: () {
                            Fluttertoast.showToast(msg: 'Clicked ${state.orders[index].id}');
                          },
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
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
    );
  }
}
