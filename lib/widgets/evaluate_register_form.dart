import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/controller/evaluate_register_controller.dart';
import 'package:tcc_ceclimar/models/animal_response.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/utils/animals_service.dart';
import 'package:tcc_ceclimar/widgets/input_field.dart';
import 'package:tcc_ceclimar/widgets/radio_btn_animal_state.dart';
import 'package:tcc_ceclimar/widgets/search_input_field.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';
import 'package:collection/collection.dart';

class EvaluateRegisterForm extends StatefulWidget {
  final RegisterResponse register;

  const EvaluateRegisterForm({
    super.key,
    required this.register
  });
  
  @override
  State<EvaluateRegisterForm> createState() => _EvaluateRegisterFormState();
}

class _EvaluateRegisterFormState extends State<EvaluateRegisterForm> {
  final _formController = EvaluateRegisterFormController();
  final _formKey = GlobalKey<FormState>();
  final AnimalService _animalService = AnimalService();

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
    _formController.nameController.text = widget.register.animal.popularName!;
    _formController.speciesController.text = widget.register.animal.species != null ? widget.register.animal.species! : '';
    _formController.classController.text = widget.register.animal.classe != null ? widget.register.animal.classe! : '';
    _formController.orderController.text = widget.register.animal.order != null ? widget.register.animal.order! : '';
    _formController.familyController.text = widget.register.animal.family != null ? widget.register.animal.family! : '';
    _formController.genuController.text = widget.register.animal.genus != null ? widget.register.animal.genus! : '';

    _formController.obsController.text = widget.register.observation != null ? widget.register.observation! : '';
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
    _speciesFocusNode.dispose();
    _classFocusNode.dispose();
    _orderFocusNode.dispose();
    _familyFocusNode.dispose();
    _genusFocusNode.dispose();
    _formController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _formController.validateForm();
    });
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 16),
            InputField(
              text: "Nome Popular",
              controller: _formController.nameController,
              validator: (value) => _formController.nameError,
            ),
            const SizedBox(height: 16),
            SearchInputField(
              text: "Classe (Opcional)",
              controller: _formController.classController,
              validator: (value) => _formController.classError,
              onChanged: (_) {
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
              text: "Espécie",
              controller: _formController.speciesController,
              validator: (value) => _formController.speciesError,
              onChanged: (_) {
                _updateDropdownOptions();
                clearRelatedFields("species");
              },
              items: _filteredSpecies,
              focusNode: _speciesFocusNode,
              onFocusUpdate: (){
                _updateDropdownOptions();
              },
            ),
            RadioRowAnimal(
              onChanged:  (String value) {
                setState(() {
                  _formController.animalStateController.text = value;
                });
              },
            ),
            const SizedBox(height: 9),
            SizedBox(
              height: 180,
              child: InputField(
                text: "Informações Adicionais (Opcional)",
                controller: _formController.obsController,
                validator: (value) => _formController.obsError,
                maxLength: 600,
                maxLines: 10,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: SendBtn(
                  onSend: () => _formController.sendEvaluation(context, widget.register),
                  onValidate: _validateForm,
                  text: "Enviar Análise",
              ),
            ),
            const SizedBox(height: 26)
          ],
        ),
      ),
    );
  }
}