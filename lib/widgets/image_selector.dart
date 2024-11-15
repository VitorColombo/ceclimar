import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/image_picker_selector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc_ceclimar/widgets/register_circular_image.dart';

class ImageSelector extends StatefulWidget {
  final double? width;
  final double? height;
  final Function onImageSelected;

  const ImageSelector({
    super.key,
    this.height,
    this.width,
    required this.onImageSelected,
  });
 
  @override
  ImageSelectorState createState() => ImageSelectorState();
}

class ImageSelectorState extends State<ImageSelector> {
  File? _selectedImage;

  Future<void> _pickImageFromCamera() async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      widget.onImageSelected(_selectedImage);
    }
  }

  Future<void> _pickImageFromGallery() async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      widget.onImageSelected(_selectedImage);
    }
  }

  Future<void> _removeImage () async {
    setState(() {
      _selectedImage = null;
    });
    widget.onImageSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RegisterCircularImageWidget(
            imageProvider: _selectedImage, 
            width: widget.width ?? 132, 
            heigth: widget.height ?? 132, 
            onTap: _showModalImagePicker,
            onRemoveTap: _removeImage,
          ),
        ],
      ),
    );
  }

  Future<void> _showModalImagePicker() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return ImagePickerModal(
          onCameraTap: _pickImageFromCamera, 
          onGalleryTap: _pickImageFromGallery,
        );
      }
    );
    return;
  }
}