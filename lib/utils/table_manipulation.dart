import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// Separate Widget for Table Manipulation Bottom Sheet
class TableManipulationBottomSheet extends StatelessWidget {
  const TableManipulationBottomSheet({Key? key}) : super(key: key);

  Future<File> _createAndGetFile() async {
    String fileContent = "Arquivo placeholder, aqui ira ser enviada a tabela gerada com todos os dados selecionados";

    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/data.txt';

    final file = File(filePath);
    await file.writeAsString(fileContent);

    return file;
  }

  Future<void> _downloadFile(BuildContext context) async {
    try {
      final file = await _createAndGetFile();
      final url = Uri.file(file.path);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Não foi possível fazer o download ${file.path}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Não foi possível fazer o download: $e')));
    }
  }

  Future<void> _shareFileViaEmail(BuildContext context) async {
    try {
      final file = await _createAndGetFile();

      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Dados de registros Fauna Marinha RS',
        text: 'Aqui será enviado o dado gerado com todos os registros selecionados',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro no compartilhamento do arquivo: $e')));
    }
  }

  Future<void> _shareFileViaWhatsApp(BuildContext context) async {
    try {
      final file = await _createAndGetFile();

      // Share the file using share_plus
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Dados de registros Fauna Marinha RS',
        text: 'Segue em anexo os dados exportados.',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro no compartilhamento do arquivo: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(PhosphorIconsLight.download),
            title: Text('Baixar Tabela'),
            onTap: () async {
              Navigator.pop(context); // Close the bottom sheet first
              await _downloadFile(context);
            },
          ),
          ListTile(
            leading: Icon(PhosphorIconsLight.envelope),
            title: Text('Enviar Tabela por Email'),
            onTap: () async {
              Navigator.pop(context); // Close the bottom sheet
              await _shareFileViaEmail(context);
            },
          ),
          ListTile(
            leading: Icon(PhosphorIconsLight.whatsappLogo),
            title: Text('Enviar Tabela por WhatsApp'),
            onTap: () async {
              Navigator.pop(context); // Close the bottom sheet
              await _shareFileViaWhatsApp(context);
            },
          ),
        ],
      ),
    );
  }
}

// How to use the bottom sheet:
// In the widget where you want to show the bottom sheet:

/*
ElevatedButton(
  onPressed: () {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const TableManipulationBottomSheet();
      },
    );
  },
  child: const Text('Show Options'),
),
*/