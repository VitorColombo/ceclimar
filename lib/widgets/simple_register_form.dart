import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tcc_ceclimar/utils/guarita_data.dart';
import 'package:tcc_ceclimar/widgets/custom_switch.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';
import '../controller/new_register_form_controller.dart';
import 'image_selector.dart';
import 'modal_help_register_image_btnsheet.dart';

class SimpleRegisterForm extends StatefulWidget {
  const SimpleRegisterForm({super.key});

  @override
  State<SimpleRegisterForm> createState() => _SimpleRegisterFormState();
}

class _SimpleRegisterFormState extends State<SimpleRegisterForm> {
  final _formController = NewRegisterFormController();
  final _formKey = GlobalKey<FormState>();
  bool isSwitchOn = false;
  bool isOnLocal = false;
  bool _isFormSubmitted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    final bool isControllerValid = _formController.validateForm();
    return isControllerValid;
  }

  void _onSwitchChanged(bool valueHour) {
    if (_isFormSubmitted) return;

    setState(() {
      _formController.changeHourSwitch();
      _formController.hourController.text = '';
      _formController.hourError = null;
      isSwitchOn = valueHour;
    });
  }

  void _onLocalSwitchChanged(bool valueLocal) {
    if (_isFormSubmitted) return;

    setState(() {
      _formController.changeLocalSwitch();
      _formController.cityController.text = '';
      _formController.beachSpotController.text = '';
      _formController.beachSpotError = null;
      _formController.cityError = null;
      isOnLocal = valueLocal;
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Por favor, habilite o serviço de localização para que possamos obter as coordenadas do animal'
              )
            )
          );
      await Future.delayed(const Duration(seconds: 3));
      await Geolocator.openLocationSettings();
      setState(() {
        _isFormSubmitted = false;
      });
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text('As permissões de localização foram negadas',
                style: TextStyle(color: Colors.white),
              )
            )
          );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
              'As permissões de localização foram negadas, para enviar o registro é necessário permitir a localização nas configurações do dispositivo',
              style: TextStyle(color: Colors.white),
              )
            )
          );
      await Future.delayed(const Duration(seconds: 3));
      await Geolocator.openLocationSettings();
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission){
      return;
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
          setState(() => 
            _formController.currentPosition = position
          );
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _submitForm() async {
    if (_validateForm()) {
      setState(() {
        _isFormSubmitted = true;
      });
      await _formController.sendSimpleRegister(context, _getCurrentPosition);
    }
  }

  List<String> _getCities() {
    return guaritas.where((element) => element.city != null).map((guarita) => guarita.city!).toSet().toList();
  }

  List<GuaritaData> _getFilteredGuaritas() {
    if (_formController.cityController.text.isEmpty) {
      return guaritas;
    } else {
      return guaritas.where((guarita) => guarita.city == _formController.cityController.text).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Stack(
              children: [
                ImageSelector(
                  onImageSelected: (image) {
                    setState(() {
                      _formController.setImage(image);
                    });
                  },
                ),
                Positioned(
                  top: 82,
                  child: ImageSelector(
                    width: 50,
                    height: 50, 
                    onImageSelected: (image) {
                      setState(() {
                        _formController.setImage2(image);
                      });
                    },                  
                  )
                ),
              ],
            ),
            Visibility(
              visible: _formController.imageError != null,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _formController.imageError ?? "",
                  style: const TextStyle(color: Colors.red)
                ),
              )
            ),
            GestureDetector(
              onTap: () {
                _showImageObservationBottomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 45),
                  Text(
                    "Dicas para as fotografias do registro ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Icon(Icons.info_outline, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 16),
            InputField(
              text: "Nome Popular",
              controller: _formController.nameController,
              validator: (value) => _formController.nameError,
              onChanged: (value) {
                setState(() {
                  _formController.nameError = null;
                });
              },
              maxLength: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: CustomSwitch(
                text: "Não estou mais no local",
                value: isOnLocal,
                onChanged: _onLocalSwitchChanged,
                onTap: _showSwitchLocalInfoBottomSheet,
                isDisabled: _isFormSubmitted,
              ),
            ),
            const SizedBox(height: 5),
            Visibility(
              visible: isOnLocal,
              child: Column(
                children: [
                  Visibility(
                    visible: _formController.locationSwitchError != null,
                    child:
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 15.0),
                        child: Text(
                          _formController.locationSwitchError ?? "", 
                          style: const TextStyle(color: Colors.red)
                        ),
                      )
                  ),
                  InputField(
                    text: "Ponto de Referencia",
                    controller: _formController.referencePointController,
                    validator: (value) => _formController.referencePointError,
                    onChanged: (value) {
                      setState(() {
                        _formController.referencePointError = null;
                        _formController.locationSwitchError = null;
                      });
                    },
                    maxLength: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          menuMaxHeight: 400,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xF6F6F6F6),
                            labelText: "Município",
                            labelStyle: Theme.of(context).textTheme.labelLarge,
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.lightBlue,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            floatingLabelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 17),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10.0),
                          ),
                          value: _formController.cityController.text.isEmpty
                              ? null
                              : _formController.cityController.text,
                          items: _getCities().map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(
                                city,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _formController.cityController.text = newValue ?? '';
                              _formController.beachSpotController.text = '';
                              _formController.beachSpotError = null;
                              _formController.cityError = null;
                              _formController.locationSwitchError = null;
                            });
                          },
                          validator: (value) => _formController.cityError,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 125,
                        child: DropdownButtonFormField<String>(
                          menuMaxHeight: 400,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xF6F6F6F6),
                            labelText: "Nº Guarita",
                            labelStyle: Theme.of(context).textTheme.labelLarge,
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.lightBlue,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            floatingLabelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 17),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10.0),
                          ),
                          value: _formController.beachSpotController.text.isEmpty
                              ? null
                              : _formController.beachSpotController.text,
                          items: _getFilteredGuaritas()
                              .map((GuaritaData guarita) {
                            return DropdownMenuItem<String>(
                              value: guarita.number,
                              child: Text(
                                guarita.number,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _formController.beachSpotController.text = newValue ?? '';
                              _formController.currentGuarita = _getFilteredGuaritas().firstWhere((element) => element.number == newValue);
                              if (_formController.cityController.text.isEmpty && _formController.currentGuarita != null && _formController.currentGuarita!.city != null) {
                                _formController.cityController.text = _formController.currentGuarita!.city!;
                              }
                              _formController.beachSpotError = null;
                              _formController.cityError = null;
                              _formController.locationSwitchError = null;
                            });
                          },
                          validator: (value) => _formController.beachSpotError,
                        ),
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _formController.beachSpotController.text = '';
                              _formController.cityController.text = '';
                              _formController.currentGuarita = null;
                            });
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: 
                            PhosphorIcon(PhosphorIcons.trash(PhosphorIconsStyle.regular), size: 24, color: Colors.grey)
                        ),
                      ),
                    ],
                  ),
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: CustomSwitch(
                text: "Presenciou o animal encalhando?",
                value: isSwitchOn,
                onChanged: _onSwitchChanged,
                onTap: _showSwitchInfoBottomSheet,
                isDisabled: _isFormSubmitted,
              ),
            ),
            const SizedBox(height: 5),
            if (isSwitchOn)
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _formController.hourController.text = pickedTime.format(context);
                          _formController.hourError = null;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: InputField(
                      text: "Horário aproximado",
                      controller: _formController.hourController,
                      validator: (value) => _formController.hourError,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: SendBtn(
                  onSend: _submitForm,
                  onValidate: _validateForm,
                  text: "Enviar Registro",
                ),
              ),
              SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  void _showImageObservationBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const ModalHelpRegisterImageBottomSheet(
          text: "Sugerimos o envio de 2 imagens, sendo uma com escala e outra sem. A escala, pode ser representada por objetos como chinelos, óculos ou até mesmo o pé.",
          imagePath: "assets/images/exemplo_foto_escala.jpg",
          height: 600,
          );
      },
    );
  }

  void _showSwitchInfoBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const ModalHelpRegisterImageBottomSheet(
          text: "Marque esse campo se você presenciou o mar trazendo o animal para a faixa de areia.",
          height: 250,
          );
      },
    );
  }

  void _showSwitchLocalInfoBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const ModalHelpRegisterImageBottomSheet(
            text: "Marque esse campo se você está enviando o registro após ter saído do local onde encontrou o animal.\n\n Aqui você pode informar um ponto de referencia o município ou o número da guarita. Quanto mais informação melhor! 😊",
          height: 350,
          );
      },
    );
  }  
}