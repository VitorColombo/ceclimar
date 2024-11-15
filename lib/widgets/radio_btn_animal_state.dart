import 'package:flutter/material.dart';

enum AnimalStateValues { state1, state2, state3, state4, state5 }

extension AnimalStateValuesExtension on AnimalStateValues {
  int get value {
    switch (this) {
      case AnimalStateValues.state1:
        return 1;
      case AnimalStateValues.state2:
        return 2;
      case AnimalStateValues.state3:
        return 3;
      case AnimalStateValues.state4:
        return 4;
      case AnimalStateValues.state5:
        return 5;
    }
  }
}

class RadioListTileExample extends StatefulWidget {
  const RadioListTileExample({super.key});

  @override
  State<RadioListTileExample> createState() => _RadioListTileExampleState();
}

class _RadioListTileExampleState extends State<RadioListTileExample> {
  AnimalStateValues? _state = AnimalStateValues.state3;
  AnimalStateValues get state => _state!;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 9.0, left: 6, right: 6),
      child: Column(
        children: [
          Row(
            children: [
              Text("Grau de decomposição"),
            ],
          ),
          SizedBox(height: 6), 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Radio<AnimalStateValues>(
                    value: AnimalStateValues.state1,
                    groupValue: _state,
                    onChanged: (AnimalStateValues? value) {
                      setState(() {
                        _state = value;
                      });
                    },
                  ),
                  Transform.translate(
                    offset: Offset(0, -10),
                    child: const Text('1')
                  ),
                ],
              ),
              Column(
                children: [
                  Radio<AnimalStateValues>(
                    value: AnimalStateValues.state2,
                    groupValue: _state,
                    onChanged: (AnimalStateValues? value) {
                      setState(() {
                        _state = value;
                      });
                    },
                  ),
                  Transform.translate(
                    offset: Offset(0, -10),
                    child: const Text('2')
                  ),                
                ],
              ),
              Column(
                children: [
                  Radio<AnimalStateValues>(
                    value: AnimalStateValues.state3,
                    groupValue: _state,
                    onChanged: (AnimalStateValues? value) {
                      setState(() {
                        _state = value;
                      });
                    },
                  ),
                  Transform.translate(
                    offset: Offset(0, -10),
                    child: const Text('3')
                  ),
                ],
              ),
              Column(
                children: [
                  Radio<AnimalStateValues>(
                    value: AnimalStateValues.state4,
                    groupValue: _state,
                    onChanged: (AnimalStateValues? value) {
                      setState(() {
                        _state = value;
                      });
                    },
                  ),
                  Transform.translate(
                    offset: Offset(0, -10),
                    child: const Text('4')
                  ),
                ],
              ),
              Column(
                children: [
                  Radio<AnimalStateValues>(
                    value: AnimalStateValues.state5,
                    groupValue: _state,
                    onChanged: (AnimalStateValues? value) {
                      setState(() {
                        _state = value;
                      });
                    },
                  ),
                  Transform.translate(
                    offset: Offset(0, -10),
                    child: const Text('5')
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}