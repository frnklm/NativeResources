import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const googleApiKey = 'YOUR KEY';

class LocationUtil {
  static String generetedLocation({
    double? latitude,
    double? longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }

  //metedo para transformar uma lat e long em um endereço
  static Future<String> getAddress(LatLng position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey';
    final response = await http.get(Uri.parse(url));
    //Json vai retornar o endereço dentro do body
    // forçar o retorno do endereço em 'results' no índice [0] e chave ['formatted_adress']
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
