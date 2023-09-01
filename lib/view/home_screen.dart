import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class FetchGoogleMap extends StatefulWidget {
  const FetchGoogleMap({Key? key}) : super(key: key);

  @override
  State<FetchGoogleMap> createState() => _FetchGoogleMapState();
}

class _FetchGoogleMapState extends State<FetchGoogleMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.569691, 104.889909),
    zoom: 15.4746,
  );

  static const Marker _kGooglePlexMarker = Marker(
    markerId: MarkerId('_kPhnomPenh'),
    infoWindow: InfoWindow(title: 'RUPP STEM Building'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(11.569691, 104.889909),
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(11.569691, 104.889909),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: {_kGooglePlexMarker},
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('RUPP STEM'),
        icon: const Icon(Icons.location_on),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
