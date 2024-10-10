import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc_ceclimar/widgets/register_circular_image.dart';

class ImageSelector extends StatefulWidget {
 
  const ImageSelector({
    super.key,
  });
 
  @override
  ImageSelectorState createState() => ImageSelectorState();
}

class ImageSelectorState extends State<ImageSelector> {
  File? _selectedImage;

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            RegisterCircularImageWidget(
              imageProvider: _selectedImage, 
              width: 132, 
              heigth: 132, onTap: 
              _showModalImagePicker
            ),
          ],
      ),
    );
  }


  void _showModalImagePicker(){
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                _pickImageFromCamera();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeria'),
              onTap: () {
                _pickImageFromGallery();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}