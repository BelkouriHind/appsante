import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appsante/main.dart';

// ERREUR CORRIGÉE 1 : Importez votre application main.dart
// Remplacez 'appsante' par le nom de votre projet si différent (voir pubspec.yaml)
import 'package:appsante/main.dart'; // OU 'package:flutter_app/main.dart;' si c'est le nom de votre projet





void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));

    await tester.pump(); // Nécessaire pour reconstruire l'UI après le tap

    await tester.pump();


    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

}




