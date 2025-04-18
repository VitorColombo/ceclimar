import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';

import 'package:tcc_ceclimar/models/register_response.dart';

class TableManipulationBottomSheet extends StatelessWidget {
  final String userRole;

  const TableManipulationBottomSheet({
    super.key,
    required this.data,
    required this.userRole,
  });

  final List<RegisterResponse> data;

  Future<File> _createAndGetExcelFile() async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/dados_fauna_marinha.xlsx';
    final file = File(filePath);

    List<RegisterResponse> filteredData = data;

    if (userRole != 'admin') {
      filteredData = data
        .where((e) => e.status.toLowerCase() == 'validado')
        .map((e) => e.copyWith(authorName: ''))
        .toList();
    }

    var excelData = convertDataToExcel(filteredData);
    List<int>? encodedData = excelData.encode();

    if (encodedData != null) {
      await file.writeAsBytes(Uint8List.fromList(encodedData));
    }

    return file;
  }

  Excel convertDataToExcel(List<RegisterResponse> data) {
    var excel = Excel.createExcel();
    Sheet sheet = excel['Registros'];
    excel.setDefaultSheet(sheet.sheetName);
    var titleCell = sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0));
    titleCell.value = TextCellValue('Fauna Marinha RS');

    CellStyle titleStyle = CellStyle(
      backgroundColorHex: ExcelColor.fromHexString('#0099FF'),
      fontColorHex: ExcelColor.fromHexString('#FFFFFF'), 
      bold: true,
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
    );

    titleCell.cellStyle = titleStyle;

    List<String> headers = [
      'ID', 'Data', 'Horário', 'Hora Encalhe', 'Imagem', 'Nome popular',
      'Espécie', 'Gênero', 'Família', 'Ordem', 'Classe', 'ID Guarita',
      'Latitude', 'Longitude', 'Município', 'Nome do informante',
      'Percepção do observador', 'Grau de decomposição', 'Observações', 'Status'
    ];

    CellStyle headerStyle = CellStyle(
      bold: true,
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
    );

    CellStyle centeredStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
    );
    Map<int, int> maxColumnWidths = {};

    sheet.merge(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0),
    CellIndex.indexByColumnRow(columnIndex: headers.length - 1, rowIndex: 0));

    for (int i = 0; i < headers.length; i++) {
      var cell = sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 1));
      cell.value = TextCellValue(headers[i]);
      cell.cellStyle = headerStyle;

      maxColumnWidths[i] = headers[i].length;
    }

    final dateFormatter = DateFormat('dd/MM/yyyy');
    final timeFormatter = DateFormat('HH:mm:ss');

    for (int i = 0; i < data.length; i++) {
      RegisterResponse register = data[i];
      int currentRow = i + 2;

      List<String> rowData = [
        register.registerNumber.toString(),
        dateFormatter.format(register.date),
        timeFormatter.format(register.date),
        register.hour ?? "",
        "${register.registerImageUrl} ${register.registerImageUrl2 ?? ""}",
        register.animal.popularName ?? "",
        register.animal.species ?? "",
        register.animal.genus ?? "",
        register.animal.family ?? "",
        register.animal.order ?? "",
        register.animal.classe ?? "",
        register.beachSpot,
        register.latitude.toString(),
        register.longitude.toString(),
        register.city,
        register.authorName,
        register.obs ?? "",
        register.sampleState?.toString() ?? "",
        register.specialistReturn ?? "",
        register.status,
      ];

      for (int j = 0; j < rowData.length; j++) {
        var cell = sheet.cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: currentRow));
        cell.value = TextCellValue(rowData[j]);

        if (![4, 16, 18].contains(j)) {
          cell.cellStyle = centeredStyle;
        }

        if (![4, 16, 18].contains(j)) {
          maxColumnWidths[j] = maxColumnWidths.containsKey(j)
              ? max(maxColumnWidths[j]!, rowData[j].length)
              : rowData[j].length;
        }
      }
    }

    for (int i = 0; i < headers.length; i++) {
      if (![4, 16, 18].contains(i)) {
        sheet.setColumnWidth(i, (maxColumnWidths[i]! + 2).toDouble());
      }else{
      sheet.setColumnWidth(i, (40));  
      }
    }

    return excel;
  }

  Future<void> _downloadFile(BuildContext context) async {
    try {
      final file = await _createAndGetExcelFile();
      final result = await OpenFilex.open(file.path);

      if (result.type != ResultType.done) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao abrir arquivo: ${result.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro no download: $e')));
    }
  }

  Future<void> _shareFile(BuildContext context) async {
    try {
      final file = await _createAndGetExcelFile();

      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Dados de registros Fauna Marinha RS',
        text: 'Arquivo gerado com registros selecionados.',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao compartilhar: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(PhosphorIconsLight.download),
            title: const Text('Baixar Tabela'),
            onTap: () async {
              Navigator.pop(context);
              await _downloadFile(context);
            },
          ),
          ListTile(
            leading: Icon(PhosphorIconsLight.share),
            title: const Text('Compartilhar Tabela'),
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