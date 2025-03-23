import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tcc_ceclimar/models/register_response.dart';

class MapScreen extends StatelessWidget {
  final List<RegisterResponse> registers;

  const MapScreen({super.key, required this.registers});

  @override
  Widget build(BuildContext context) {
    // Debugging: Print the first register's latitude and longitude
    if (registers.isNotEmpty) {
      print('First register latitude: ${registers.first.latitude}');
      print('First register longitude: ${registers.first.longitude}');
    }

    // Check if the registers list is empty
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

    // Parse latitude and longitude from the first register
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
                  // Show details when a marker is tapped
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${register.animal.species} - ${register.date}'),
                    ),
                  );
                },
                child: Icon(
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