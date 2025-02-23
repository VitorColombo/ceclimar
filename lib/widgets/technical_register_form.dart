import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tcc_ceclimar/models/animal_response.dart';
import 'package:collection/collection.dart';
import 'package:tcc_ceclimar/utils/animals_service.dart';
import 'package:tcc_ceclimar/utils/guarita_data.dart';
import 'package:tcc_ceclimar/widgets/custom_switch.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/search_input_field.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';
import 'package:tcc_ceclimar/widgets/send_btn_disabled.dart';

import '../controller/new_register_form_controller.dart';
import 'image_selector.dart';
import 'modal_help_register_image_btnsheet.dart';

class TechnicalRegisterForm extends StatefulWidget {
  const 
  TechnicalRegisterForm({super.key});

  @override
  State<TechnicalRegisterForm> createState() => _TechnicalRegisterFormState();
}

class _TechnicalRegisterFormState extends State<TechnicalRegisterForm> {
  final _formController = NewRegisterFormController();
  final _formKey = GlobalKey<FormState>();
  final AnimalService _animalService = AnimalService();
  bool isSwitchOn = false;
  bool isOnLocal = false;
  bool isBtnEnabled = false;
  bool _isFormSubmitted = false;
  
  final List<String> species = [];
  final List<String> classes = [];
  final List<String> orders = [];
  final List<String> families = [];
  final List<String> genus = [];
  List<AnimalResponse> animals = [];
  List<AnimalResponse> _allAnimals = [];
  List<String> _filteredSpecies = [];
  List<String> _filteredClasses = [];
  List<String> _filteredOrders = [];
  List<String> _filteredFamilies = [];
  List<String> _filteredGenus = [];

  final FocusNode _speciesFocusNode = FocusNode();
  final FocusNode _classFocusNode = FocusNode();
  final FocusNode _orderFocusNode = FocusNode();
  final FocusNode _familyFocusNode = FocusNode();
  final FocusNode _genusFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _formController.nameController.addListener(_updateBtnStatus);
    _formController.hourController.addListener(_updateBtnStatus);
    _formController.speciesController.addListener(_updateBtnStatus);
    _formController.cityController.addListener(_updateBtnStatus);
    _formController.beachSpotController.addListener(_updateBtnStatus);
    _loadAnimals();
    _initializeFilteredLists();

    _speciesFocusNode.addListener(_handleFocusChange);
    _classFocusNode.addListener(_handleFocusChange);
    _orderFocusNode.addListener(_handleFocusChange);
    _familyFocusNode.addListener(_handleFocusChange);
    _genusFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (mounted && (_speciesFocusNode.hasFocus ||
        _classFocusNode.hasFocus ||
        _orderFocusNode.hasFocus ||
        _familyFocusNode.hasFocus ||
        _genusFocusNode.hasFocus)) {
      _updateDropdownOptions();
    }
  }

  Future<void> _loadAnimals() async {
    _allAnimals = await _animalService.getAnimals();
    if(mounted){
      setState(() {
        _populateFilterLists();
      });
    }
  }

  void _populateFilterLists(){
    setState(() {
      species.addAll(
        _allAnimals
          .map((animal) => animal.scientificName)
          .where((species) => species != null && species.isNotEmpty)
          .map((species) => species!)
          .toSet()
          .toList(),
      );
      classes.addAll(
        _allAnimals
          .map((animal) => animal.classe)
          .where((classe) => classe != null && classe.isNotEmpty)
          .map((classe) => classe!)
          .toSet()
          .toList(),
      );
      orders.addAll(
        _allAnimals
          .map((animal) => animal.order)
          .where((order) => order != null && order.isNotEmpty)
          .map((order) => order!)
          .toSet()
          .toList(),
      );
      families.addAll(
        _allAnimals
          .map((animal) => animal.family)
          .where((family) => family != null && family.isNotEmpty)
          .map((family) => family!)
          .toSet()
          .toList(),
      );
      genus.addAll(
        _allAnimals
          .map((animal) => animal.genus)
          .where((genus) => genus != null && genus.isNotEmpty)
          .map((genus) => genus!)
          .toSet()
          .toList(),
      );
    });
  }

  void _initializeFilteredLists(){
    setState(() {
      _filteredSpecies = species;
      _filteredClasses = classes;
      _filteredOrders = orders;
      _filteredFamilies = families;
      _filteredGenus = genus;
    });
  }

  List<AnimalResponse> _filterAnimals() {
    List<AnimalResponse> filteredAnimals = _allAnimals;

    if (_formController.speciesController.text.isNotEmpty) {
      filteredAnimals = filteredAnimals.where((animal) => animal.scientificName!.contains(_formController.speciesController.text)).toList();
    }
    if (_formController.classController.text.isNotEmpty) {
      filteredAnimals = filteredAnimals.where((animal) => animal.classe!.contains(_formController.classController.text)).toList();
    }
    if (_formController.orderController.text.isNotEmpty) {
      filteredAnimals = filteredAnimals.where((animal) => animal.order!.contains(_formController.orderController.text)).toList();
    }
    if (_formController.familyController.text.isNotEmpty) {
      filteredAnimals = filteredAnimals.where((animal) => animal.family!.contains(_formController.familyController.text)).toList();
    }
    if (_formController.genuController.text.isNotEmpty) {
      filteredAnimals = filteredAnimals.where((animal) => animal.genus!.contains(_formController.genuController.text)).toList();
    }

    return filteredAnimals;
  }

  void _updateDropdownOptions() {
    List<AnimalResponse> filteredAnimals = _filterAnimals();

    setState(() {
      _filteredClasses = filteredAnimals.map((animal) => animal.classe!).toSet().toList();
      _filteredSpecies = filteredAnimals.map((animal) => animal.scientificName!).toSet().toList();
      _filteredOrders = filteredAnimals.map((animal) => animal.order!).toSet().toList();
      _filteredFamilies = filteredAnimals.map((animal) => animal.family!).toSet().toList();
      _filteredGenus = filteredAnimals.map((animal) => animal.genus!).toSet().toList();
      
      if (_speciesFocusNode.hasFocus) {
        _filteredSpecies = _allAnimals
            .where((animal) => !(_formController.classController.text.isNotEmpty && animal.classe?.toLowerCase() != _formController.classController.text.toLowerCase()) &&
                                !(_formController.orderController.text.isNotEmpty && animal.order?.toLowerCase() != _formController.orderController.text.toLowerCase()) &&
                                !(_formController.familyController.text.isNotEmpty && animal.family?.toLowerCase() != _formController.familyController.text.toLowerCase()) &&
                                !(_formController.genuController.text.isNotEmpty && animal.genus?.toLowerCase() != _formController.genuController.text.toLowerCase())
              )
              .map((animal) => animal.scientificName!)
              .toSet()
              .toList();
        } else if (_genusFocusNode.hasFocus) {
        _filteredGenus = _allAnimals
            .where((animal) => !(_formController.classController.text.isNotEmpty && animal.classe?.toLowerCase() != _formController.classController.text.toLowerCase()) &&
                                !(_formController.orderController.text.isNotEmpty && animal.order?.toLowerCase() != _formController.orderController.text.toLowerCase()) &&
                                !(_formController.familyController.text.isNotEmpty && animal.family?.toLowerCase() != _formController.familyController.text.toLowerCase()) &&
                                !(_formController.speciesController.text.isNotEmpty && animal.scientificName?.toLowerCase() != _formController.speciesController.text.toLowerCase())
              )
            .map((animal) => animal.genus!)
            .toSet()
            .toList();
      } else if (_familyFocusNode.hasFocus) {
          _filteredFamilies = _allAnimals
            .where((animal) => !(_formController.classController.text.isNotEmpty && animal.classe?.toLowerCase() != _formController.classController.text.toLowerCase()) &&
                                !(_formController.orderController.text.isNotEmpty && animal.order?.toLowerCase() != _formController.orderController.text.toLowerCase()) &&
                                !(_formController.genuController.text.isNotEmpty && animal.genus?.toLowerCase() != _formController.genuController.text.toLowerCase()) &&
                                !(_formController.speciesController.text.isNotEmpty && animal.scientificName?.toLowerCase() != _formController.speciesController.text.toLowerCase())
              )
            .map((animal) => animal.family!)
            .toSet()
            .toList();
      } else if (_orderFocusNode.hasFocus) {
          _filteredOrders = _allAnimals
            .where((animal) => !(_formController.classController.text.isNotEmpty && animal.classe?.toLowerCase() != _formController.classController.text.toLowerCase()) &&
                                !(_formController.familyController.text.isNotEmpty && animal.family?.toLowerCase() != _formController.familyController.text.toLowerCase()) &&
                                !(_formController.genuController.text.isNotEmpty && animal.genus?.toLowerCase() != _formController.genuController.text.toLowerCase()) &&
                                !(_formController.speciesController.text.isNotEmpty && animal.scientificName?.toLowerCase() != _formController.speciesController.text.toLowerCase())
              )
            .map((animal) => animal.order!)
            .toSet()
            .toList();
        } else if (_classFocusNode.hasFocus) {
          _filteredClasses = _allAnimals
            .where((animal) => !(_formController.orderController.text.isNotEmpty && animal.order?.toLowerCase() != _formController.orderController.text.toLowerCase()) &&
                                !(_formController.familyController.text.isNotEmpty && animal.family?.toLowerCase() != _formController.familyController.text.toLowerCase()) &&
                                !(_formController.genuController.text.isNotEmpty && animal.genus?.toLowerCase() != _formController.genuController.text.toLowerCase()) &&
                                !(_formController.speciesController.text.isNotEmpty && animal.scientificName?.toLowerCase() != _formController.speciesController.text.toLowerCase())
              )
            .map((animal) => animal.classe!)
            .toSet()
            .toList();
        }
      if (_formController.speciesController.text.isNotEmpty) {
        AnimalResponse? selectedAnimal = _allAnimals.firstWhereOrNull(
          (animal) => animal.scientificName == _formController.speciesController.text,
        );
        if (selectedAnimal != null) {
          _formController.classController.text = selectedAnimal.classe ?? '';
          _formController.orderController.text = selectedAnimal.order ?? '';
          _formController.familyController.text = selectedAnimal.family ?? '';
          _formController.genuController.text = selectedAnimal.genus ?? '';
        }
      } else if (_formController.genuController.text.isNotEmpty) {
        AnimalResponse? selectedAnimal = _allAnimals.firstWhereOrNull(
          (animal) => animal.genus == _formController.genuController.text,
        );
        if (selectedAnimal != null) {
          _formController.familyController.text = selectedAnimal.family ?? '';
          _formController.orderController.text = selectedAnimal.order ?? '';
          _formController.classController.text = selectedAnimal.classe ?? '';
        }
      } else if (_formController.familyController.text.isNotEmpty) {
        AnimalResponse? selectedAnimal = _allAnimals.firstWhereOrNull(
          (animal) => animal.family == _formController.familyController.text,
        );
        if (selectedAnimal != null) {
          _formController.orderController.text = selectedAnimal.order ?? '';
          _formController.classController.text = selectedAnimal.classe ?? '';
        }
      } else if (_formController.orderController.text.isNotEmpty) {
        AnimalResponse? selectedAnimal = _allAnimals.firstWhereOrNull(
          (animal) => animal.order == _formController.orderController.text,
        );
        if (selectedAnimal != null) {
          _formController.classController.text = selectedAnimal.classe ?? '';
        }
      }
    });
  }

  void clearRelatedFields(String field) {
    switch (field) {
      case 'class':
        _formController.orderController.text = '';
        _formController.familyController.text = '';
        _formController.genuController.text = '';
        _formController.speciesController.text = '';
        break;
      case 'order':
        _formController.familyController.text = '';
        _formController.genuController.text = '';
        _formController.speciesController.text = '';
        break;
      case 'family':
        _formController.genuController.text = '';
        _formController.speciesController.text = '';
        break;
      case 'genus':
        _formController.speciesController.text = '';
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    if(mounted){

    _formController.dispose();
    _speciesFocusNode.dispose();
    _classFocusNode.dispose();
    _orderFocusNode.dispose();
    _familyFocusNode.dispose();
    _genusFocusNode.dispose();
    }
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _formController.validateTechnicalForm();
    });
    return _formKey.currentState?.validate() ?? false;
  }

  void _onSwitchChanged(bool valueHour) {
    if (_isFormSubmitted) return;

    setState(() {
      _formController.changeHourSwitch();
      _formController.hourController.text = '';
      _formController.hourError = null;
      isSwitchOn = valueHour;
      _updateBtnStatus();
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
      _updateBtnStatus();
    });
  }

  void _updateBtnStatus() {
    setState(() {
      isBtnEnabled = _formController.isBtnEnable();
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Por favor, habilite o serviço de localização para que possamos obter as coordenadas do animal'
              )
            )
          );
      await Future.delayed(const Duration(seconds: 3));
      await Geolocator.openLocationSettings();
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
              'As permissões de localização foram negadas, para enviar o registro é necessário habilitar a localização nas configurações do dispositivo',
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
                ImageSelector(onImageSelected: _formController.setImage),
                Positioned(
                  top: 82,
                  child: ImageSelector(width: 50, height: 50, onImageSelected: _formController.setImage2)
                ),
              ],
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
              onChanged: (_) => _updateBtnStatus(),
              maxLength: 50,
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
              child: Row(
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
                          _updateBtnStatus();
                        });
                      },
                      validator: (value) => _formController.cityError,
                    ),
                  ),
                  const SizedBox(width: 20),
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
                          _updateBtnStatus();
                        });
                      },
                      validator: (value) => _formController.beachSpotError,
                    ),
                  ),
                ],
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
                        _updateBtnStatus();
                      });
                      }
                    },
                    child: AbsorbPointer(
                      child: InputField(
                      text: "Horário aproximado",
                      controller: _formController.hourController,
                      validator: (value) => _formController.hourError,
                      onChanged: (_) {
                        _updateBtnStatus(); 
                      },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            SizedBox(
              height: 180,
              child: InputField(
                text: "Observações (Opcional)",
                controller: _formController.obsController,
                validator: (value) => _formController.obsError,
                onChanged: (_) => _updateBtnStatus(),
                maxLength: 600,
                maxLines: 10,
              ),
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Classe (Opcional)",
              controller: _formController.classController,
              validator: (value) => _formController.classError,
              onChanged: (_) {
                _updateBtnStatus();
                _updateDropdownOptions();
                clearRelatedFields("class");
              },
              items: _filteredClasses,
              focusNode: _classFocusNode,
              onFocusUpdate: (){
                _updateDropdownOptions();
              },
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Ordem (Opcional)",
              controller: _formController.orderController,
              validator: (value) => _formController.orderError,
              onChanged: (_) {
                _updateBtnStatus();
                _updateDropdownOptions();
                clearRelatedFields("order");
              },
              items: _filteredOrders,
              focusNode: _orderFocusNode,
              onFocusUpdate: (){
                _updateDropdownOptions();
              },
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Família (Opcional)",
              controller: _formController.familyController,
              validator: (value) => _formController.familyError,
              onChanged: (_) {
                _updateBtnStatus();
                _updateDropdownOptions();
                clearRelatedFields("family");
              },
              items: _filteredFamilies,
              focusNode: _familyFocusNode,
              onFocusUpdate: (){
                _updateDropdownOptions();
              },
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Gênero (Opcional)",
              controller: _formController.genuController,
              validator: (value) => _formController.genuError,
              onChanged: (_) {
                _updateBtnStatus();
                _updateDropdownOptions();
                clearRelatedFields("genus");
              },
              items: _filteredGenus,
              focusNode: _genusFocusNode,
              onFocusUpdate: (){
                _updateDropdownOptions();
              },
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Espécie (Opcional)",
              controller: _formController.speciesController,
              validator: (value) => _formController.speciesError,
              onChanged: (_) {
                _updateBtnStatus();
                _updateDropdownOptions();
                clearRelatedFields("species");
              },
              items: _filteredSpecies,
              focusNode: _speciesFocusNode,
              onFocusUpdate: (){
                _updateDropdownOptions();
              },
            ),
            const SizedBox(height: 16),
            if(isBtnEnabled)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: SendBtn(
                    onSend: _submitForm,
                    onValidate: _validateForm,
                    text: "Enviar Registro",
                ),
              )
            else
              const SizedBox(
                width: double.infinity,
                height: 56,
                child: DisabledSendBtn(
                    text: "Enviar Registro",
                ),
              ),
            const SizedBox(height: 26)
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
          text: "Marque esse campo se você está enviando o registro após ter saído do local onde encontrou o animal.",
          height: 250,
          );
      },
    );
  }  
}