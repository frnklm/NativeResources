import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:native_resources/utils/location_util.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  //Usa o pacote Location para pegar a lat. e long.
  Future<void> _getCurrentLocation() async {
    final localData = await Location().getLocation();
    //recebe os parametros de latitude e longitude para passar a classe location util,
    //para por na url e gerar a localização
    final staticMapImageUrl = LocationUtil.generetedLocation(
      latitude: localData.latitude,
      longitude: localData.longitude,
    );

    //muda o estado assim que o preview recebe os dados de location util
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Text('Localização não informada')
              : Image.network(
                  _previewImageUrl.toString(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Localização Atual'),
              //referencia da função e não invocar a função
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Selecione no mapa'),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
