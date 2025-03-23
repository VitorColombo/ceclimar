import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcc_ceclimar/widgets/send_btn.dart';


void main() {
  group('SendBtn', () {
    testWidgets('Validar input e funcionamento da snackbar de erro', (WidgetTester tester) async {
      bool validationResult = false;
      bool sendCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SendBtn(
              text: 'Send',
              onValidate: () => validationResult,
              onSend: () => sendCalled = true,
            ),
          ),
        ),
      );


      await tester.tap(find.widgetWithText(TextButton, 'Send'));
      await tester.pumpAndSettle();

      expect(find.text('Por favor, verifique os dados de entrada.'), findsOneWidget);
      expect(sendCalled, isFalse);
    });

    testWidgets('Testar envio com sucesso e icone de loading no botão indicanto carregamento', (WidgetTester tester) async {
      bool validationResult = true;
      bool sendCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SendBtn(
              text: 'Send',
              onValidate: () => validationResult,
              onSend: () async {
                await Future.delayed(Duration(milliseconds: 500)); 
                sendCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.widgetWithText(TextButton, 'Send'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(sendCalled, isTrue);
    });
  });
}