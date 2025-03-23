import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcc_ceclimar/widgets/password_input.dart';

void main() {
  group('PasswordInput', () {
    testWidgets('Validar o toogle de esconder e mostrar senha', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordInput(
              text: 'Password',
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.text('Password'), findsOneWidget);

      var state = tester.state<PasswordInputState>(find.byType(PasswordInput));
      expect(state.obscureText, isTrue);

      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pumpAndSettle();

      state = tester.state<PasswordInputState>(find.byType(PasswordInput));
      expect(state.obscureText, isFalse);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pumpAndSettle();

      state = tester.state<PasswordInputState>(find.byType(PasswordInput));
      expect(state.obscureText, isTrue);

      controller.dispose();
    });

    testWidgets('Validar erro de input', (WidgetTester tester) async {
      final controller = TextEditingController();
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: PasswordInput(
                text: 'Password',
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), '');
      await tester.pumpAndSettle();

      formKey.currentState?.validate();
      await tester.pumpAndSettle();

      expect(find.text('Password is required'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'short');
      await tester.pumpAndSettle();

      formKey.currentState?.validate();
      await tester.pumpAndSettle();

      expect(find.text('Password must be at least 6 characters'), findsOneWidget);

      controller.dispose();
    });

    testWidgets('Validar input com sucesso', (WidgetTester tester) async {
      final controller = TextEditingController();
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: PasswordInput(
                text: 'Password',
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      // Enter valid input
      await tester.enterText(find.byType(TextFormField), 'senhaforte123');
      await tester.pumpAndSettle();

      formKey.currentState?.validate();
      await tester.pumpAndSettle(); 

      expect(formKey.currentState?.validate(), true);
      expect(find.text('Password must be at least 6 characters'), findsNothing);

      controller.dispose();
    });

     testWidgets('Validar remoção do espaço', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordInput(
              text: 'Password',
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'testa espaço');
      await tester.pumpAndSettle();

      expect(controller.text, 'testaespaço');

      controller.dispose();
    });
  });
}