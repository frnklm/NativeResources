import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:native_resources/models/place_location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
    //Gerar uma localização inicial
    this.initialLocation = const PlaceLocation(
      latitude: 37.419857,
      longitude: -122.078827,
    ),
    //utilizar mapa como leitura ou não
    this.isReadOnly = false,
  }) : super(key: key);

  final PlaceLocation initialLocation;
  final bool isReadOnly;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  //Função para retornar dentro do mapa uma posição
  //Posição recebida do onTap do GoogleMap
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        //Botão para checkar a localização selecionada
        actions: <Widget>[
          if (!widget.isReadOnly)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _pickedPosition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedPosition);
                    },
            )
        ],
      ),
      //InitialCamaeraPosition necessita receber uma classe com uma posição.
      //Classe PlaceLocation retorna o valor de lat e long
      //InitialCamaeraPosition recebe CameraPosition que necessita do target
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          //zoom padrão que já vem descrito no link
          zoom: 13,
        ),
        //Ternário que recebe a pisição pickada no mapa pelo onTap e joga na _selectLocation
        onTap: widget.isReadOnly ? null : _selectLocation,
        markers: (_pickedPosition == null && !widget.isReadOnly)
            ? <Marker>{}
            : {
                Marker(
                  markerId: const MarkerId('l1'),
                  position: _pickedPosition ??
                      LatLng(
                        widget.initialLocation.latitude,
                        widget.initialLocation.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
