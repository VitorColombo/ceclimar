import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/widgets/modal_bottomsheet.dart';

class MapScreen extends StatelessWidget {
  final List<RegisterResponse> registers;

  const MapScreen({super.key, required this.registers});

  @override
  Widget build(BuildContext context) {
    if (registers.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('OpenStreetMap'),
        ),
        body: Center(
          child: Text('No registers available'),
        ),
      );
    }

    final initialCenter = LatLng(
      double.parse(registers.first.latitude),
      double.parse(registers.first.longitude),
    );

    return FlutterMap(
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MarkerLayer(
          markers: registers.map((register) {
            return Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(
                double.parse(register.latitude),
                double.parse(register.longitude),
              ),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ModalBottomSheet(
                        text: 'Animal: ${register.animal.species}\nDate: ${register.date}\nStatus: ${register.status}',
                        buttons: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the modal
                            },
                            child: const Text('Close'),
                          ),
                          // Add more buttons as needed
                        ],
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}