import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/order/order_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/socket_service.dart';

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
        Set<Marker> markers = _buildMarkers(state as OrderLoaded);
        return StreamBuilder(
          stream: getIt.get<SocketService>().getStream(),
          builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
            if (snapshot.hasData) {
              markers.removeWhere((marker) => marker.markerId == MarkerId('driver'));
              markers.add(
                Marker(
                  markerId: MarkerId('driver'),
                  position: snapshot.data ?? LatLng(0, 0),
                  infoWindow: InfoWindow(
                    title: 'Sofőr',
                  ),
                ),
              );
            }
            return SizedBox(
              width: 550.w,
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
                markers: markers,
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
      },
    );
  }

  Set<Marker> _buildMarkers(OrderLoaded state) {
    final markers = {
      Marker(
        markerId: MarkerId('destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: LatLng(
          (state).currentRoute.last.latitude,
          (state).currentRoute.last.longitude,
        ),
        infoWindow: InfoWindow(
          title: 'Úticél',
        ),
      ),
    };
    if (!state.passengerPickedUp) {
      markers.add(
        Marker(
          markerId: MarkerId('passenger'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: LatLng(
            (state).currentPassengerPos.latitude,
            (state).currentPassengerPos.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Ön',
          ),
        ),
      );
    }
    return markers;
  }
}
