import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/widgets/circular_image_widget.dart';
import 'package:tcc_ceclimar/widgets/evaluate_register_form.dart';
import 'package:tcc_ceclimar/widgets/view_register_image.dart';
import '../widgets/page_header.dart';

class EvaluateRegister extends StatefulWidget {
  static const String routeName = '/evaluateRegister';
  final Function(int) updateIndex;
  final RegisterResponse register;

  const EvaluateRegister({
    super.key,
    this.updateIndex = _defaultUpdateIndex,
    required this.register,
  });

  static void _defaultUpdateIndex(int index) {
  }

  @override
  _EvaluateRegisterState createState() => _EvaluateRegisterState();
}

class _EvaluateRegisterState extends State<EvaluateRegister> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            PageHeader(
              text: "Avaliar Registro",
              icon: const Icon(Icons.arrow_back),
              onTap: Navigator.of(context).pop,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return ViewRegisterImage(
                                        imageProvider: widget.register.registerImage,
                                      );
                                    },
                                  );
                                },
                                child: CircularImageWidget(
                                  imageProvider: widget.register.registerImage.image,
                                  width: 148,
                                  heigth: 170,
                                ),
                              ),
                              if(widget.register.registerImage2 != null)
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return ViewRegisterImage(
                                          imageProvider: widget.register.registerImage2!,
                                        );
                                      },
                                    );
                                  },
                                  child: CircularImageWidget(
                                    imageProvider: widget.register.registerImage2!.image,
                                    width: 148,
                                    heigth: 170,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Registro Nº ${widget.register.uid}',
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.user(PhosphorIconsStyle.regular), size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.register.authorName,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.mapPin(PhosphorIconsStyle.regular), size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.register.city,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.calendarBlank(PhosphorIconsStyle.regular), size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.register.date,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(children: [
                                    if(widget.register.hour != null)
                                      Text("Encalhe presenciado às ${widget.register.hour}")
                                    else
                                      Text("Encalhe não presenciado")
                                  ]),
                                  const SizedBox(height: 8),
                                  Row(children: [
                                    Text("Próximo a guarita ${widget.register.beachSpot}")
                                  ]),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 90,
                                      decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 71, 169, 218),
                                      border: Border.all(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(6),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Latitude',
                                          style: const TextStyle(fontSize: 14, color: Colors.white),
                                        ),
                                        Text(
                                          '${widget.register.location.latitude}',
                                          style: const TextStyle(fontSize: 14, color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 90,
                                      decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 71, 169, 218),
                                      border: Border.all(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(6),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Longitude',
                                          style: const TextStyle(fontSize: 14, color: Colors.white),                                        ),
                                        Text(
                                          '${widget.register.location.longitude}',
                                          style: const TextStyle(fontSize: 14, color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      EvaluateRegisterForm(register: widget.register)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}