import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/widgets/register_status_label.dart';

class RegisterDetailPage extends StatelessWidget {
  final RegisterResponse? register;
  static const String routeName = '/registerDetail';

  const RegisterDetailPage({super.key, required this.register});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            collapsedHeight: 60,
            expandedHeight: 260,
            backgroundColor: Colors.white,
            shadowColor: Color.fromARGB(0, 173, 145, 145),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_outlined, shadows: [Shadow(color: Colors.black, blurRadius: 20)],),
                iconSize: 24.0,
                color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: register!.registerImage,
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
                            register!.animal.popularName,
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
                                    'Registro Nº ${register!.uid}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.person, size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${register!.authorName ?? 'Cientista Anônimo'}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_pin, size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${register!.city}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today, size: 20,),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${register!.date}',
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
                                    width: 90,
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
                                          '${register!.location?.latitude ?? 'N/A'}',
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    width: 90,
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
                                          '${register!.location?.longitude ?? 'N/A'}',
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
                            'Nome Popular: ${register!.animal.popularName}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Espécie: ${register!.animal.species}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Encontrado próximo a guarita ${register!.beachSpot}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                            decoration: BoxDecoration(
                              color: getSampleStateColor(register!.sampleState),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Grau de decomposição ${register!.sampleState}',
                              style: TextStyle(fontSize: 16, color: register!.sampleState == 2 ? Colors.grey[600] : Colors.white),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(15),
                            ),
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
                                  'Animal de espécie ${register!.animal.species} ordem ${register!.animal.order} família ${register!.animal.family} gênero ${register!.animal.gender}.',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Foram encontrados outros X registros desta espécie na região',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
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