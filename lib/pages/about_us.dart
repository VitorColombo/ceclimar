import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
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
                image: const AssetImage('assets/images/logo.png'),
                pageHeader: PageHeader(
                  text: "Sobre o app",
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 30, right: 30, top: 10),
                  child: Column(
                    children: [
                      Text("Versão 1.0.0", style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 20),
                      Accordion(
                        initialOpeningSequenceDelay: 0,
                        scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
                        disableScrolling: true,
                        headerPadding: const EdgeInsets.only(top: 20, bottom: 20, left: 6, right: 6),
                        rightIcon: Icon(PhosphorIcons.caretDown(PhosphorIconsStyle.regular)),
                        headerBackgroundColor: Colors.white,
                        headerBorderWidth: 1,
                        headerBorderRadius: 6,
                        headerBorderColor: const Color.fromARGB(255, 71, 169, 218),
                        headerBorderColorOpened: const Color.fromARGB(255, 71, 169, 218),
                        contentBorderColor: const Color.fromARGB(255, 71, 169, 218),
                        children: [
                          AccordionSection(
                            header: const Text(
                              'Projeto Fauna Marinha RS',
                              style: TextStyle(
                                fontWeight: FontWeight.normal, 
                                fontSize: 18,
                                color:  Color.fromARGB(255, 71, 169, 218),
                              )
                            ),
                            content: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "O projeto Fauna Marinha RS foi criado em 2013 pelo biólogo Maurício Tavares, do CECLIMAR/UFRGS, com o objetivo de promover a educação ambiental e divulgar informações sobre a biodiversidade marinha e costeira do litoral norte do Rio Grande do Sul. Desde 2017, o projeto vem capacitando os guarda-vidas que trabalham na operação golfinho durante o veraneio, a fim de que os mesmos adquiram informações pertinentes sobre os principais animais que aparecem encalhados na orla gaúcha.",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          AccordionSection(
                            header: const Text(
                              'Sobre o aplicativo',
                              style: TextStyle(
                                fontWeight: FontWeight.normal, 
                                fontSize: 18,
                                color: Color.fromARGB(255, 71, 169, 218),
                              )
                            ),
                            content: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "O aplicativo Fauna Mar foi elaborado em uma cooperação entre o IFRS Campus Osório e o Ceclimar com o objetivo fornecer uma aplicação de ciência cidadã que possa disseminar a ciência para a população local, ao mesmo tempo que auxilia na obtenção e na análise de dados de fauna marinha do nosso litoral.",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          AccordionSection(
                            header: const Text(
                              'Desenvolvimento',
                              style: TextStyle(
                                fontWeight: FontWeight.normal, 
                                fontSize: 18,
                                color: Color.fromARGB(255, 71, 169, 218),
                              )
                            ),
                            content: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "Desenvolvido pelo aluno Vitor Colombo Nunes como projeto de conclusão do curso de Análise e Desenvolvimento de Sistemas do IFRS - Campus Osório.",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text("Confira nossas redes sociais:", style: Theme.of(context).textTheme.bodyMedium),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialMediaButton(
                              'https://www.facebook.com/faunamarinhars',
                              PhosphorIcons.facebookLogo()),
                          _buildSocialMediaButton(
                              'https://www.instagram.com/faunamarinhars',
                              PhosphorIcons.instagramLogo()),
                          _buildSocialMediaButton(
                              'https://www.youtube.com/c/FaunaMarinhaRS/featured',
                              PhosphorIcons.youtubeLogo()),
                          _buildSocialMediaButton(
                              'mailto:fauna_marinha@ufrgs.br',
                              PhosphorIcons.envelopeSimple()),
                          _buildSocialMediaButton(
                              'https://open.spotify.com/show/2ZeHXdjgzmRUpLRJEX0XYY?si=gOk-QtrVSoinxJ_jvWqNJA',
                              PhosphorIcons.spotifyLogo()),
                          _buildSocialMediaButton(
                              'https://t.me/FaunaMarinhaRS',
                              PhosphorIcons.telegramLogo()),
                        ],
                      ),
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

  Widget _buildSocialMediaButton(String url, IconData icon) {
    return IconButton(
      onPressed: () async {
        final Uri uri = Uri.parse(url);
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $uri');
        }
      },
      icon: Icon(icon, color: const Color.fromARGB(255, 31, 73, 95),),
      iconSize: 30,
    );
  }
}