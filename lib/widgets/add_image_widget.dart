import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_selectedImage != null)
          Image.file(_selectedImage!, height: 200, width: 200),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickImageFromCamera,
          child: const Text('Open Camera'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _pickImageFromGallery,
          child: const Text('Open Gallery'),
        ),
      ],
    );
  }
}