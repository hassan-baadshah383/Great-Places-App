import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:native_features_app/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  Function locPicker;
  LocationInput(this.locPicker, {Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  double? lat;
  double? lon;

  Future<void> _setCurrentLocation() async {
    final LocationData loc = await Location().getLocation();
    // if (loc == null) {
    //   return;
    // }
    setState(() {
      lat = loc.latitude;
      lon = loc.longitude;
    });
    widget.locPicker(lat, lon);
  }

  Future<void> _setLocationOnMap() async {
    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      builder: (context) {
        return MapScreen(
          isSelecting: true,
        );
      },
      fullscreenDialog: true,
    ));
    if (selectedLocation == null) {
      return;
    }
    setState(() {
      lat = selectedLocation.latitude;
      lon = selectedLocation.longitude;
    });
    widget.locPicker(lat, lon);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: lat == null
              ? const Center(
                  child: Text(
                  'No location chosen!',
                  style: TextStyle(color: Colors.grey),
                ))
              : GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: LatLng(lat!, lon!), zoom: 15.0),
                  markers: {
                      Marker(
                          markerId: const MarkerId('staticLocation'),
                          position: LatLng(lat!, lon!))
                    }),
        ),
        const SizedBox(
          height: 10,
        ),
        FittedBox(
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                    onPressed: _setCurrentLocation,
                    icon: const Icon(Icons.location_pin),
                    label: const Text('Set current location')),
                TextButton.icon(
                    onPressed: _setLocationOnMap,
                    icon: const Icon(Icons.map),
                    label: const Text('Set location on map'))
              ],
            ),
          ),
        )
      ],
    );
  }
}
