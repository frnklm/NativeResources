import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageIpunt extends StatefulWidget {
  final Function onSelectImage;

  const ImageIpunt({
    Key? key,
    required this.onSelectImage,
  }) : super(key: key);

  @override
  _ImageIpuntState createState() => _ImageIpuntState();
}

class _ImageIpuntState extends State<ImageIpunt> {
  File? _submitedImage;

  _takePicture() async {
    // tirar a foto
    final ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedFile == null) {
      return;
    }

    setState(() {
      _submitedImage = File(pickedFile.path);
    });
    //pegar o local da foto
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_submitedImage!.path);
    final savedImage = await _submitedImage!.copy(
      '${appDir.path}/$fileName',
    );
    //salvar no método a imagem salva já com caminho do diretório
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _submitedImage != null
              ? Image.file(
                  _submitedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Text('Nenhuma Imagem'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            label: const Text('Tirar Foto'),
            icon: const Icon(Icons.camera),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
