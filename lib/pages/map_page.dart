import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = Set<Marker>();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  Location location = new Location();

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(6.267470,-75.570862),
    zoom: 16.0,
  );

  _getLocation() async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    try{
      _locationData = await location.getLocation();
      print("latitud: ${_locationData.latitude}, longitud ${_locationData.longitude}");
      setState(() {
        _markers.add(
            Marker(
              markerId: const MarkerId("Mi ubicación"),
              icon: BitmapDescriptor.defaultMarker,
              position: LatLng(_locationData.latitude!,_locationData.longitude!),
              infoWindow: const InfoWindow(title: "Mi ubicación"),
            ));
      });
    } on Exception{
     //
    }
  }

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _cameraPosition,
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _showMarkers();
        },
      ),
    );
  }

  void _showMarkers() {
    setState(() {
      _markers.add(
        const Marker(
          markerId: MarkerId("Universidad de Antioquia"),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(6.267470,-75.570862),
          infoWindow: InfoWindow(title: "Universidad de Antioquia",
          snippet: "Sede principal"),
        ));
      _markers.add(
          const Marker(
              markerId: MarkerId("Sede Posgrados"),
              icon: BitmapDescriptor.defaultMarker,
              position: LatLng(6.1981071,-75.5872137),
              infoWindow: InfoWindow(title: "Sede posgrados"),
          ));
    });
  }
}
