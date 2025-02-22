import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/widgets/register_status_label.dart';
import 'package:intl/intl.dart';

class RegisterDetailPage extends StatefulWidget {
  final RegisterResponse? register;
  static const String routeName = '/registerDetail';

  const RegisterDetailPage({super.key, required this.register});

  @override
  _RegisterDetailPageState createState() => _RegisterDetailPageState();
}

class _RegisterDetailPageState extends State<RegisterDetailPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openImageDialog(String imageUrl) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.9),
            body: Stack(
              children: [
                Center(
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.5,
                    maxScale: 4,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.error,
                          color: Colors.white,
                          size: 50,
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 5,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 30,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      widget.register?.registerImageUrl ?? '',
      widget.register?.registerImageUrl2 ?? '',
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
              background: Stack(
                alignment: Alignment.bottomCenter,
                  children: [
                     PageView.builder(
                      controller: _pageController,
                      itemCount: images.length,
                      onPageChanged: (index) {
                      setState(() {
                      _currentPage = index;
                     });
                     },
                     itemBuilder: (context, index) {
                     return GestureDetector(
                      onTap: () => _openImageDialog(images[index]),
                       child: Image.network(
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
                        ),
                     );
                      },
                    ),
                    if(images.length == 1)
                      Positioned(
                        bottom: 10,
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    if(images.length > 1)
                      Positioned(
                        bottom: 10,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                images.length,
                                (index) => Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 2.0
                                    ),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentPage == index
                                          ? Colors.white
                                          : Colors.grey[500],
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                  ),
                                )
                           ),
                        ),
                    ),
                  ],
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
                            widget.register!.animal.popularName!,
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
                                    'Registro Nº ${widget.register!.registerNumber}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.user(PhosphorIconsStyle.regular), size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.register!.authorName,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.mapPin(PhosphorIconsStyle.regular), size: 20),
                                      const SizedBox(width: 8),
                                      Text(widget.register!.city.isEmpty ? "Cidade não informada" : widget.register!.city),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.calendarBlank(PhosphorIconsStyle.regular), size: 20,),
                                      const SizedBox(width: 8),
                                      Text(DateFormat('dd/MM/yyyy').format(widget.register!.date),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
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
                                          widget.register!.latitude,
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
                                          widget.register!.longitude,
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
                          StatusLabel(status: '${widget.register?.status}', borderColor: Colors.transparent),
                          const SizedBox(height: 8),
                          Text(
                            'Nome Popular: ${widget.register!.animal.popularName}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Visibility(
                            visible: widget.register!.animal.species != null && widget.register!.animal.species!.isNotEmpty,
                            child: Text(
                              'Espécie: ${widget.register!.animal.species}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Visibility(
                            visible: widget.register!.beachSpot.isNotEmpty,
                            child: Text(
                              'Encontrado próximo a guarita ${widget.register!.beachSpot}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                            decoration: BoxDecoration(
                              color: getSampleStateColor(widget.register!.sampleState),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: 
                            Text(
                              widget.register!.sampleState != null
                                ? 'Grau de decomposição ${widget.register!.sampleState}'
                                : 'Registro em análise',
                              style: TextStyle(
                              fontSize: 16,
                              color: widget.register!.sampleState == 2 ? Colors.grey[600] : Colors.white,
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
                              visible: widget.register!.specialistReturn != null && widget.register!.status == "Validado" && widget.register!.animal.species != null && widget.register!.animal.order != null && widget.register!.animal.family != null && widget.register!.animal.genus != null,
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
                                    RichText(
                                    text: TextSpan(
                                      style: const TextStyle(fontSize: 16, color: Colors.black),
                                      children: [
                                      const TextSpan(text: 'Animal da espécie '),
                                      TextSpan(
                                        text: widget.register!.animal.species,
                                        style: const TextStyle(fontStyle: FontStyle.italic),
                                      ),
                                      const TextSpan(text: ', ordem '),
                                      TextSpan(
                                        text: widget.register!.animal.order,
                                        style: const TextStyle(fontStyle: FontStyle.normal),
                                      ),
                                      const TextSpan(text: ', família '),
                                      TextSpan(
                                        text: widget.register!.animal.family,
                                        style: const TextStyle(fontStyle: FontStyle.normal),
                                      ),
                                      const TextSpan(text: ' e gênero '),
                                      TextSpan(
                                        text: widget.register!.animal.genus,
                                        style: const TextStyle(fontStyle: FontStyle.italic),
                                      ),
                                      const TextSpan(text: '.'),
                                      ],
                                    ),
                                    ),
                                  const SizedBox(height: 8),
                                  Visibility(
                                    visible: widget.register?.specialistReturn != null && widget.register!.specialistReturn!.isNotEmpty,
                                    child: RichText(
                                    text: TextSpan(
                                      text: "${widget.register!.specialistReturn}",
                                      style: const TextStyle(fontSize: 16, color: Colors.black),
                                      ),
                                    )
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
        return const Color.fromARGB(255, 178, 227, 170);
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