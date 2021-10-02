import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double logitude;
  final String? address;

  PlaceLocation({
    required this.latitude,
    required this.logitude,
    this.address,
  });
}

class Place {
  final String id;
  final String title;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.image,
  });
}
