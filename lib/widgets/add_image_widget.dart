import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/modal_bottomsheet.dart';
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
        return ModalBottomSheet(
          text: "Escolha a forma de envio da imagem", 
          buttons: [
            Card(
              shadowColor: Colors.black.withOpacity(0.7),
              elevation: 6.0,
              color: const Color.fromARGB(255, 71, 169, 218),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white,),
                title: const Text("Câmera", style: TextStyle(color: Colors.white)),
                onTap: _pickImageFromCamera,
              ),
            ),
            Card(
              shadowColor: Colors.black.withOpacity(0.7),
              elevation: 6.0,
              color: const Color.fromARGB(255, 71, 169, 218),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: const Text("Galeria", style: TextStyle(color: Colors.white)),
                onTap: _pickImageFromGallery,
              ),
            ),
          ],
        );
      }
    );
  }
}