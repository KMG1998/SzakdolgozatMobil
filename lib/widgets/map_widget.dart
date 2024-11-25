import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/order/order_cubit.dart';

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
        return SizedBox(
          width: 500.w,
          height: 500.h,
          child: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: CameraPosition(
                target: LatLng(
                  widget.initialPos.latitude,
                  widget.initialPos.longitude,
                ),
                zoom: 12),
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            mapToolbarEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              Marker(
                markerId: MarkerId('passenger'),
                position: LatLng(
                  widget.initialPos.latitude,
                  widget.initialPos.longitude,
                ),
                infoWindow: InfoWindow(
                  title: 'Ön',
                )
              ),
              Marker(
                  markerId: MarkerId('destination'),
                  position: LatLng(
                    (state as OrderLoaded).currentRoute.last.latitude,
                    (state).currentRoute.last.longitude,
                  ),
                  infoWindow: InfoWindow(
                    title: 'Úticél',
                  )
              ),
            },
            polylines: {
              Polyline(
                polylineId: const PolylineId('direction_polyline'),
                color: Theme.of(context).colorScheme.primary,
                width: 5,
                points: (state).currentRoute.map((e) => LatLng(e.latitude, e.longitude)).toList(),
              )
            },
          ),
        );
      },
    );
  }
}
