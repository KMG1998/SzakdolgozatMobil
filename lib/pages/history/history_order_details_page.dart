import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/date_formatter.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/numeric_constant_converter.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/history/history_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/history/history_state.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/app_decoration.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/theme_helper.dart';

class HistoryOrderDetails extends StatelessWidget {
  HistoryOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (a,b)=>{},
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Text(
                    'Fuvar részletek',
                    style: theme.textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
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
                if (state is HistoryLoaded) {
                  final selectedOrder = state.orders[state.selectedOrderIndex!];
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _createItem('Azonosító: ${selectedOrder.id}'),
                      _createItem('Indulási pozíció: ${selectedOrder.startAddress}'),
                      _createItem('Uticél pozíció: ${selectedOrder.destinationAddress}'),
                      _createItem('Létrehozás időpontja: ${DateFormatter.formatTimestamp(selectedOrder.startDateTime)}'),
                      _createItem('Lezárás időpontja: ${DateFormatter.formatTimestamp(selectedOrder.finishDateTime)}'),
                      _createItem(
                          'Fuvar állapota: ${NumericConstantConverter.convertClosureType(selectedOrder.closureType)}'),
                      _createItem('Fuvar költsége: ${selectedOrder.price} Ft')
                    ],
                  );
                }
                return Center(
                  child: Text(
                    'Sikertelen betöltés!',
                    style: theme.textTheme.headlineLarge!.copyWith(color: Colors.red),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _createItem(String text) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2),
        borderRadius: BorderRadiusStyle.circleBorder15,
      ),
      child: Center(
        child: Text(
          text,
          style: theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
