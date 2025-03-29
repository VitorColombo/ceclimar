import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tcc_ceclimar/widgets/modal_bottomsheet.dart';

class RegisterModalBottomSheet extends ModalBottomSheet {
  const RegisterModalBottomSheet({
    super.key,
    required super.text,
    required super.buttons,
    required this.imageUrl,
    required this.animalSpecies,
    required this.date,
    required this.userName,
  });

  final String imageUrl;
  final String animalSpecies;
  final String date;
  final String userName;

  @override
  State<RegisterModalBottomSheet> createState() => _RegisterModalBottomSheetState();
}

class _RegisterModalBottomSheetState extends State<RegisterModalBottomSheet> {
  bool _isLoading = true;

  void _onImageLoaded() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      constraints: const BoxConstraints(maxHeight: 700),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.imageUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Skeletonizer(
                    enabled: _isLoading,
                    child: Image.network(
                      widget.imageUrl,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                      frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) {
                              _onImageLoaded();
                            }
                          });
                          return child;
                        }
                        return AnimatedOpacity(
                          opacity: frame == null ? 0 : 1,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeOut,
                          child: child,
                        );
                      },
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted && _isLoading) {
                              _onImageLoaded();
                            }
                          });
                          return child;
                        } else {
                          return SizedBox(
                            height: 200,
                            width: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        _onImageLoaded();
                        return SizedBox(
                          height: 200,
                          width: 200,
                          child: const Icon(
                            Icons.error_outline,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            Text(
              widget.animalSpecies,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Data do envio: ${widget.date.split(' ')[0].split('-').reversed.join('/')}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Usuário: ${widget.userName}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),

            const SizedBox(height: 20),
            ...widget.buttons.map((button) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: button,
              ),
            )),
          ],
        ),
      ),
    );
  }
}