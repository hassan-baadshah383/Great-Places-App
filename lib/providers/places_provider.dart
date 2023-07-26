import 'dart:io';

import 'package:flutter/material.dart';
import '../models/place.dart';
import '../helper/db_helper.dart';

class Places with ChangeNotifier {
  List<Place> _greatPlaces = [];

  List<Place> get allPlaces {
    return [..._greatPlaces];
  }

  Place findByid(String id) {
    if (_greatPlaces.isEmpty) {
      return null;
    }
    return _greatPlaces.firstWhere((place) => place.id == id);
  }

  void addPlace(String tit, File img, double latitude, double longitude) async {
    final Place pl = Place(
        id: DateTime.now().toString(),
        title: tit,
        image: img,
        location: Location(latitude: latitude, longitude: longitude));
    _greatPlaces.add(pl);
    notifyListeners();
    await DbHelper.insertData('Places', {
      'id': pl.id,
      'title': pl.title,
      'image': pl.image.path,
      'latitude': pl.location.latitude,
      'longitude': pl.location.longitude
    });
  }

  Future<void> fetchData() async {
    final dbList = await DbHelper.getData('Places');
    _greatPlaces = dbList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: Location(
                latitude: item['latitude'], longitude: item['longitude'])))
        .toList();
    notifyListeners();
  }
}
