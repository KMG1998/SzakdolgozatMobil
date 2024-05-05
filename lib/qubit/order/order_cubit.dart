import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/Order.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/orderService.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/userService.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/vehicleToUserService.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderState(isLoading: false, hasError: false));

  createOrder() async {
    emit(state.copyWith(
      currentOrder: null,
      isLoading: true,
      hasError: false,
      errorMessage: null,
    ));
    String randomDriverId = (await getIt.get<UserService>().getDriver(46.25002012408016, 20.14643973265109)).UUID;
    debugPrint(randomDriverId);
    String vehicleId = await getIt.get<VehicleToUserService>().getVehicleByDriver(randomDriverId);
    Order newOrder = await getIt
        .get<OrderService>()
        .createOrder(getIt.get<UserService>().currentUser!.id, randomDriverId, vehicleId);
    emit(state.copyWith(
      currentOrder: newOrder,
      isLoading: false,
      hasError: false,
      errorMessage: null,
    ));
  }
}
