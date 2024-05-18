import 'dart:io';

class Location {
  double latitude;
  double longitude;

  Location({required this.latitude, required this.longitude});
}

class Place {
  String id;
  String title;
  File image;
  Location location;

  Place(
      {required this.id,
      required this.title,
      required this.image,
      required this.location});
}
