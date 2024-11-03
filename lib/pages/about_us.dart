import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/header_banner_widget.dart';
import '../widgets/page_header.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = '/aboutUs'; 
  final Function(int) updateIndex;

  const AboutUs({
    super.key, 
    this.updateIndex = _defaultUpdateIndex,
  });
  
  static void _defaultUpdateIndex(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            backgroundColor: Colors.white,
            shadowColor: Color.fromARGB(0, 173, 145, 145),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  HeaderBannerWidget(image: AssetImage('assets/images/logo.png')),
                  PageHeader(
                    text: "Sobre o app",
                    icon: const Icon(Icons.arrow_back, color: Colors.white,),
                    onTap: () => updateIndex(0),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            pinned: true,
            floating: false,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  "texto sobre o projeto",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ]
            )
          )
        ]
      )
    );
  }
}