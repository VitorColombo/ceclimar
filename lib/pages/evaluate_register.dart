import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/widgets/circular_image_widget.dart';
import 'package:tcc_ceclimar/widgets/evaluate_register_form.dart';
import 'package:tcc_ceclimar/widgets/view_register_image.dart';
import '../widgets/page_header.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class EvaluateRegister extends StatefulWidget {
  static const String routeName = '/evaluateRegister';
  final RegisterResponse register;

  const EvaluateRegister({
    super.key,
    required this.register,
  });

  @override
  EvaluateRegisterState createState() => EvaluateRegisterState();
}

class EvaluateRegisterState extends State<EvaluateRegister> {
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
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
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
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return ViewRegisterImage(
                                      imageUrl: widget.register.registerImageUrl,
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: CircularImageWidget(
                                  imageProvider: NetworkImage(widget.register.registerImageUrl),
                                  width: 148,
                                  heigth: 170,
                                ),
                              ),
                            ),
                            if (widget.register.registerImageUrl2 != null && widget.register.registerImageUrl2!.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return ViewRegisterImage(
                                        imageUrl: widget.register.registerImageUrl2!,
                                      );
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: CircularImageWidget(
                                    imageProvider: NetworkImage(widget.register.registerImageUrl2!),
                                    width: 148,
                                    heigth: 170,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Registro Nº ${widget.register.registerNumber}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.user(PhosphorIconsStyle.regular), size: 20),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          widget.register.authorName,
                                          style: const TextStyle(fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.mapPin(PhosphorIconsStyle.regular), size: 20),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          widget.register.city.isEmpty ? "Cidade não informada" : widget.register.city,
                                          style: const TextStyle(fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.calendarBlank(PhosphorIconsStyle.regular), size: 20),
                                      const SizedBox(width: 8),
                                      Text(DateFormat('dd/MM/yyyy').format(widget.register.date),
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(children: [
                                    Flexible(
                                      child: Text(
                                        widget.register.hour != null && widget.register.hour!.isNotEmpty
                                            ? "Encalhe presenciado às ${widget.register.hour}"
                                            : "Encalhe não presenciado",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    )
                                  ]),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 110,
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
                                      const Text(
                                        'Latitude',
                                        style: TextStyle(fontSize: 14, color: Colors.white),
                                      ),
                                      Text(
                                        widget.register.latitude,
                                        style: const TextStyle(fontSize: 14, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: 110,
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
                                      const Text(
                                        'Longitude',
                                        style: TextStyle(fontSize: 14, color: Colors.white),
                                      ),
                                      Text(
                                        widget.register.longitude,
                                        style: const TextStyle(fontSize: 14, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                          
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: widget.register.beachSpot.isNotEmpty,
                            child: Text(
                              "Próximo a guarita ${widget.register.beachSpot}",
                              style: const TextStyle(fontSize: 16),
                              ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: widget.register.referencePoint != null && widget.register.referencePoint!.isNotEmpty,
                            child: Padding(
                              padding: EdgeInsets.only(top: widget.register.beachSpot.isNotEmpty ? 8.0 : 0),
                              child: Text(
                                "Ponto de referência: ${widget.register.referencePoint}",
                                  style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
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