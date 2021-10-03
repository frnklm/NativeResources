import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:native_resources/models/place_location.dart';
import 'package:native_resources/utils/db_util.dart';
import 'package:native_resources/utils/location_util.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  //Carrega os dados inseridos no DB
  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    //insere dentro de _items os valores carregados de dataList,
    //transformando as linhas em um Place() em um ListMap chave e valor
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            //File ta na imagem porque será inserido o path da imagem
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['lat'],
              longitude: item['lng'],
              address: item['address'],
            ),
          ),
        )
        //toList para converter o MAP para um List
        .toList();
    notifyListeners();
  }

  List<Place> get item {
    // retornar clone da lista
    return [..._items];
  }

  int get itemsCount {
    // retornar quantidade dos itens
    return _items.length;
  }

  Place itemByIndex(int index) {
    // retornar item pelo indice
    return _items[index];
  }

  //adicionar local
  Future<void> addPlace(String title, File image, LatLng position) async {
    String address = await LocationUtil.getAddress(position);

    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
    );
    _items.add(newPlace);

    //insere os valores dentro do DB
    DbUtil.insert('places',
        //valores são recebidos como MAP
        {
          'id': newPlace.id,
          'title': newPlace.title,
          //no campo imagem será recebido o path da imagem
          'image': newPlace.image.path,
          'lat': position.latitude,
          'lng': position.longitude,
          'address': address,
        });
    notifyListeners();
  }
}
