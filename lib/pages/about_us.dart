import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tcc_ceclimar/widgets/header_banner_widget.dart';
import '../widgets/page_header.dart';
import 'package:url_launcher/url_launcher.dart';

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
            expandedHeight: 300,
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: HeaderBannerWidget(
                image: AssetImage('assets/images/logo.png'),
                pageHeader: PageHeader(
                  text: "Sobre o app",
                  icon: const Icon(Icons.arrow_back, color: Colors.white,),
                  onTap: () => updateIndex(0),
                  color: Colors.white,
              ),  
              ),
            ),
            pinned: true, 
            floating: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Sobre o projeto Fauna Marinha RS",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "O projeto Fauna Marinha RS foi criado em 2013 pelo biólogo Maurício Tavares, do CECLIMAR/UFRGS, com o objetivo de promover a educação ambiental e divulgar informações sobre a biodiversidade marinha e costeira do litoral norte do Rio Grande do Sul. Desde 2017, o projeto vem capacitando os guarda-vidas que trabalham na operação golfinho durante o veraneio, a fim de que os mesmos adquiram informações pertinentes sobre os principais animais que aparecem encalhados na orla gaúcha.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Sobre o aplicativo",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "O aplicativo Fauna Mar foi elaborado em uma cooperação entre o IFRS Campus Osório e o Ceclimar com o objetivo fornecer uma" 
                        " aplicação de ciência cidadã que possa disseminar a ciência para a população local, ao mesmo tempo que, auxilia"
                        " a na obtenção e na análise de dados de fauna marinha do nosso litoral.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Desenvolvimento",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Desenvolvido pelo aluno Vitor Colombo Nunes como projeto de conclusão do de Análise e Desenvolvimento de Sistemas do IFRS - Campus Osório.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Conheça nossas outras plataformas",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              String url = 'https://www.facebook.com/faunamarinhars';
                              final Uri uri = Uri.parse(url);
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            },
                            icon: const Icon(PhosphorIcons.facebookLogo),
                            iconSize: 30,
                          ),
                          IconButton(
                            onPressed: () async {
                              String url = 'https://www.instagram.com/fauna_marinha_rs';
                              final Uri uri = Uri.parse(url);
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            },
                            icon: const Icon(PhosphorIcons.instagramLogo),
                            iconSize: 30,
                          ),
                          IconButton(
                            onPressed: () async {
                              String url = 'https://www.youtube.com/c/FaunaMarinhaRS/featured';
                              final Uri uri = Uri.parse(url);
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            },
                            icon: const Icon(PhosphorIcons.youtubeLogo),
                            iconSize: 30,
                          ),
                          IconButton(
                            onPressed: () async {
                              String url = 'mailto:fauna_marinha@ufrgs.br';
                              final Uri uri = Uri.parse(url);
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            },
                            icon: const Icon(PhosphorIcons.envelopeSimple),
                            iconSize: 30,
                          ),
                          IconButton(
                            onPressed: () async {
                              String url = 'https://open.spotify.com/show/2ZeHXdjgzmRUpLRJEX0XYY?si=gOk-QtrVSoinxJ_jvWqNJA';
                              final Uri uri = Uri.parse(url);
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            },
                            icon: const Icon(PhosphorIcons.spotifyLogo),
                            iconSize: 30,
                          ),
                          IconButton(
                            onPressed: () async {
                              String url = 'https://t.me/FaunaMarinhaRS';
                              final Uri uri = Uri.parse(url);
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            },
                            icon: const Icon(PhosphorIcons.telegramLogo),
                            iconSize: 30,
                          )                        
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}