import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/order/order_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';

class MapWidget extends StatefulWidget {
  final Position initialPos;

  const MapWidget({super.key, required this.initialPos});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: 400.v,
              height: 800.h,
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    widget.initialPos.latitude,
                    widget.initialPos.longitude,
                  ),
                  zoom: 14
                ),

                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId('direction_polyline'),
                    color: Theme.of(context).colorScheme.primary,
                    width: 5,
                    points: (state as OrderLoaded).currentRoute.map((e) => LatLng(e.latitude, e.longitude)).toList(),
                  )
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
