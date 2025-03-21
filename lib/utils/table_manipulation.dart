import 'dart:io';
import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:tcc_ceclimar/models/register_response.dart';

class TableManipulationBottomSheet extends StatelessWidget {
  const TableManipulationBottomSheet({super.key, required this.data});

  final List<RegisterResponse> data;

  Future<File> _createAndGetFile() async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/dados_fauna_marinha.csv';
    final file = File(filePath);
    String csv = convertDataToCsv(data);
    await file.writeAsString(csv);

    return file;
  }

String convertDataToCsv(List<RegisterResponse> data) {
  String csvHeader = 'ID,Data,Horário,Hora Encalhe,Imagem,Nome popular,Espécie,Gênero,Família,Ordem,Classe,ID Guarita,Latitude,Longitude,Localidade,Município,Nome do informante,Percepção do observador,Grau de decomposição,Observações\n';
  final dateFormatter = DateFormat('dd/MM/yyyy');
  final timeFormatter = DateFormat('HH:mm:ss');

  String csvData = csvHeader;
  for (RegisterResponse register in data) {
    String formattedDate = dateFormatter.format(register.date);
    String formattedTime = timeFormatter.format(register.date);
    String csvRow =
        '${_escapeCsvField(register.registerNumber.toString())},' // ID
        '${_escapeCsvField(formattedDate)},' // Data
        '${_escapeCsvField(formattedTime)},' // Horário
        '${_escapeCsvField(register.hour ?? "")},'  // Hora Encalhe
        '${_escapeCsvField("${register.registerImageUrl} ${register.registerImageUrl2 ?? ""}")},' //Imagens
        '${_escapeCsvField(register.animal.popularName ?? "")},' // Nome popular
        '${_escapeCsvField(register.animal.species ?? "")},' // Espécie
        '${_escapeCsvField(register.animal.genus ?? "")},' // Gênero
        '${_escapeCsvField(register.animal.family ?? "")},' // Família
        '${_escapeCsvField(register.animal.order ?? "")},' // Ordem
        '${_escapeCsvField(register.animal.classe ?? "")},' // Classe
        '${_escapeCsvField(register.beachSpot)},'// ID Guarita
        '${_escapeCsvField(register.latitude.toString())},' // Latitude
        '${_escapeCsvField(register.longitude.toString())},' // Longitude
        '${_escapeCsvField("localidade")},' //Localidade
        '${_escapeCsvField(register.city)},' // Município
        '${_escapeCsvField(register.authorName)},' // Nome do informante
        '${_escapeCsvField(register.obs ?? "")},' // Percepção do observador
        '${_escapeCsvField(register.sampleState.toString() ?? "")},' // Grau de decomposição
        '${_escapeCsvField(register.specialistReturn ?? "")}\n'; // Observações

    csvData += csvRow;
  }

  return csvData;
}

String _escapeCsvField(String field) {
  if (field.contains(',') || field.contains('"') || field.contains('\n')) {
    return '"${field.replaceAll('"', '""')}"';
  }
  return field;
}


  Future<void> _downloadFile(BuildContext context) async {
    try {
      final file = await _createAndGetFile();
      final result = await OpenFilex.open(file.path);

      if (result.type == ResultType.done) {
        print('Sucesso ao baixar arquivo!');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Não foi possível abrir o arquivo: ${result.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Não foi possível fazer o download: $e')));
    }
  }

  Future<void> _shareFile(BuildContext context) async {
    try {
      final file = await _createAndGetFile();

      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Dados de registros Fauna Marinha RS',
        text: 'Arquivo gerado a partir do app com os registros selecionados',
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
              Navigator.pop(context);
              await _downloadFile(context);
            },
          ),
          ListTile(
            leading: Icon(PhosphorIconsLight.share),
            title: Text('Compartilhar tabela'),
            onTap: () async {
              Navigator.pop(context);
              await _shareFile(context);
            },
          ),
        ],
      ),
    );
  }
}