import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:native_features_app/providers/places_provider.dart';
import 'package:native_features_app/screens/map_screen.dart';

class PlaceDetail extends StatelessWidget {
  String id;
  PlaceDetail(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<Places>(context, listen: false).findByid(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace == null ? '' : selectedPlace.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: selectedPlace == null
                ? const Text('')
                : Image.file(
                    selectedPlace.image,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                selectedPlace == null
                    ? null
                    : Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => MapScreen(
                              isSelecting: false,
                              initialLocation: LatLng(
                                  selectedPlace.location.latitude,
                                  selectedPlace.location.longitude),
                            )));
              },
              child: const Text(
                'View on map',
                style: TextStyle(fontSize: 16),
              )),
        ],
      ),
    );
  }
}
