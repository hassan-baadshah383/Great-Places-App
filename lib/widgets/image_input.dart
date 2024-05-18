import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sys;

class ImageInput extends StatefulWidget {
  Function sendImage;

  ImageInput(this.sendImage, {Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  // ignore: avoid_init_to_null
  File? _storedImage = null;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final File imageFile2 = File(imageFile.path);
    final appDir = await sys.getApplicationDocumentsDirectory();
    final imageName = path.basename(imageFile.path);
    final savedImage = await imageFile2.copy('${appDir.path}/$imageName');
    widget.sendImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 120,
          decoration:
              BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                )
              : const Center(
                  child: Text(
                    'No image taken!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
        ),
        const SizedBox(
          width: 20,
        ),
        TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: const Text('Take a photo'))
      ],
    );
  }
}
