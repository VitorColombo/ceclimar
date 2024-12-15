import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/widgets/register_status_label.dart';
import 'package:intl/intl.dart';

class RegisterDetailPage extends StatelessWidget {
  final RegisterResponse? register;
  static const String routeName = '/registerDetail';

  const RegisterDetailPage({super.key, required this.register});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      register?.registerImageUrl ?? '',
      register?.registerImageUrl2 ?? '',
    ].where((image) => image.isNotEmpty).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            collapsedHeight: 60,
            expandedHeight: 260,
            backgroundColor: Colors.white,
            shadowColor: const Color.fromARGB(0, 173, 145, 145),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_outlined,
                shadows: [Shadow(color: Colors.black, blurRadius: 20)],
              ),
              iconSize: 24.0,
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: PageView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    images[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate(
            [
              SizedBox(
                height: 700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            register!.popularName,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Registro Nº ${register!.registerNumber}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.user(PhosphorIconsStyle.regular), size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        register!.authorName,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.mapPin(PhosphorIconsStyle.regular), size: 20),
                                      const SizedBox(width: 8),
                                      Text(register!.city.isEmpty ? "Cidade não informada" : register!.city),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.calendarBlank(PhosphorIconsStyle.regular), size: 20,),
                                      const SizedBox(width: 8),
                                      Text(DateFormat('dd/MM/yyyy').format(register!.date),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 95,
                                      decoration: BoxDecoration(
                                      color: Colors.grey[200],
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
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          register!.latitude,
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    width: 95,
                                      decoration: BoxDecoration(
                                      color: Colors.grey[200],
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
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          register!.longitude,
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          StatusLabel(status: '${register?.status}', borderColor: Colors.transparent),
                          const SizedBox(height: 8),
                          Text(
                            'Nome Popular: ${register!.popularName}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Visibility(
                            visible: register!.species != null && register!.species!.isNotEmpty,
                            child: Text(
                              'Espécie: ${register!.species}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Visibility(
                            visible: register!.beachSpot.isNotEmpty,
                            child: Text(
                              'Encontrado próximo a guarita ${register!.beachSpot}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                            decoration: BoxDecoration(
                              color: getSampleStateColor(register!.sampleState),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: 
                            Text(
                              register!.sampleState != null
                                ? 'Grau de decomposição ${register!.sampleState}'
                                : 'Registro em análise',
                              style: TextStyle(
                              fontSize: 16,
                              color: register!.sampleState == 2 ? Colors.grey[600] : Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Visibility(
                              visible: register!.species != null && register!.order != null && register!.family != null && register!.genu != null,
                              child: Column(
                                children: [
                                  Text(
                                    'Parecer do profissional',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Animal de espécie ${register!.species} ordem ${register!.order} família ${register!.family} gênero ${register!.genu}.',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Visibility(
                                    visible: register?.specialistReturn != null && register!.specialistReturn!.isNotEmpty,
                                    child: Text(
                                      "${register!.specialistReturn}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        )
      ]
    )
    );
  }

  Color getSampleStateColor(int? sampleState) {
    switch (sampleState) {
      case 1:
        return Color.fromARGB(255, 178, 227, 170);
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      case 5:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}