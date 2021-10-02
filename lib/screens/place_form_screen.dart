import 'dart:io';

import 'package:flutter/material.dart';
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

  void _selectImage(File pickedImage) {
    //seleciona a imagem retirar no image_input
    _pickedImage = pickedImage;
  }

  void _submitForm() {
    //submeter o fomulário
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);

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
                      const LocationInput(),
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
