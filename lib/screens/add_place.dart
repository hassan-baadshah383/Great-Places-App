import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/places_provider.dart';
import '../widgets/location_input.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/addPlace';

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _focusNode = FocusNode();
  final TextEditingController? _titleController = TextEditingController();
  File? _image;
  double? latitude;
  double? longitude;

  void _imagePicker(File image) {
    _image = image;
  }

  void _locationPicker(double lat, double lon) {
    latitude = lat;
    longitude = lon;
  }

  void savePlace() {
    if (_titleController == null ||
        _image == null ||
        latitude == null ||
        longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Please enter complete information.',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return;
    }
    Provider.of<Places>(context, listen: false)
        .addPlace(_titleController.text.trim(), _image!, latitude!, longitude!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(label: Text('Title')),
                      controller: _titleController,
                      focusNode: _focusNode,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ImageInput(_imagePicker),
                    const SizedBox(
                      height: 20,
                    ),
                    LocationInput(_locationPicker),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
                onPressed: savePlace,
                icon: const Icon(Icons.add),
                label: const Text('Add Place')),
          )
        ],
      ),
    );
  }
}
