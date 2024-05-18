import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final LatLng initialLocation;
  final bool isSelecting;
  const MapScreen(
      {Key? key,
      this.initialLocation = const LatLng(30.3753, 69.3451),
      this.isSelecting = false})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? pickedLocation;

  void _setLocation(LatLng position) {
    setState(() {
      pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Select a location'),
          centerTitle: true,
          actions: widget.isSelecting
              ? [
                  IconButton(
                      onPressed: () {
                        pickedLocation == null
                            ? null
                            : Navigator.of(context).pop(pickedLocation);
                      },
                      icon: const Icon(
                        Icons.check,
                      ))
                ]
              : []),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: widget.initialLocation,
              zoom: pickedLocation == null && widget.isSelecting ? 5 : 15.0),
          markers: pickedLocation == null && widget.isSelecting
              ? {}
              : {
                  Marker(
                      markerId: const MarkerId('m1'),
                      position: pickedLocation ??
                          LatLng(widget.initialLocation.latitude,
                              widget.initialLocation.longitude))
                },
          onTap: widget.isSelecting ? _setLocation : null),
    );
  }
}
