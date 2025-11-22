import 'package:flutter/material.dart';

import 'modal_bottomsheet.dart';

class ImagePickerModal extends StatelessWidget {
  final Function() onCameraTap;
  final Function() onGalleryTap;

  const ImagePickerModal({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return ModalBottomSheet(
      text: "Escolha a forma de envio da imagem", 
      buttons: [
        Card(
          shadowColor: Color.fromRGBO(0, 0, 0, 0.7),
          elevation: 6.0,
          color: const Color.fromARGB(255, 31, 73, 95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            leading: const Icon(Icons.camera_alt, color: Colors.white,),
            title: const Text("Câmera", style: TextStyle(color: Colors.white)),
            onTap: onCameraTap,
          ),
        ),
        Card(
          shadowColor: Color.fromRGBO(0, 0, 0, 0.7),
          elevation: 6.0,
          color: const Color.fromARGB(255, 71, 169, 218),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.white),
            title: const Text("Galeria", style: TextStyle(color: Colors.white)),
            onTap: onGalleryTap,
          ),
        ),
      ],
    );
  }
}
