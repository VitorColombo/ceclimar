import 'package:flutter/material.dart';
import 'package:tcc_ceclimar/widgets/base_home_card.dart';
import 'package:url_launcher/url_launcher.dart';

class RedirectHomeCard extends BaseHomeCard {
  final String websiteUrl;

  const RedirectHomeCard({
    super.key,
    required super.text,
    required super.icon,
    required this.websiteUrl,
  });

  @override
  void onTapAction(BuildContext context) async {
    final Uri url = Uri.parse(websiteUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível acessar a funcionalidade. Tente novamente mais tarde.')),
      );
    }
  }
}
