import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:native_resources/providers/great_places.dart';
import 'package:native_resources/utils/app_routes.dart';
import 'package:native_resources/widgets/image_input.dart';
import 'package:native_resources/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({Key? key}) : super(key: key);

  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedLocation;

  //seleciona a imagem retirar no image_input
  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  //seleciona uma localização
  void _selectLocation(LatLng location) {
    setState(() {
      _pickedLocation = location;
    });
  }

  //submeter o fomulário
  void _submitForm() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
      _pickedLocation!,
    );

    Navigator.of(context).pushReplacementNamed(AppRoutes.homeApp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lugar'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Titulo'),
                      ),
                      const SizedBox(height: 10),
                      ImageIpunt(onSelectImage: _selectImage),
                      const SizedBox(height: 10),
                      LocationInput(
                        onSelectedLocation: _selectLocation,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
              label: const Text(
                'Adicionar',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.amber),
              onPressed: () {
                _submitForm();
              },
            ),
          ],
        ));
  }
}
