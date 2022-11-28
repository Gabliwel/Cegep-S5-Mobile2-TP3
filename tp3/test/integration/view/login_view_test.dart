import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tp3/main.dart' as app;
import 'package:tp3/utils/constants.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login page test', () {
    testWidgets('with good credential, logs you in and sends you to the welcome view',
        (tester) async {
      app.main();

      String email = "test@hotmail.com";
      String password = "test12345";

      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const ValueKey('emailSignInField')), email);
      await tester.enterText(find.byKey(const ValueKey('passwordSignInField')), password);

      await tester.tap(find.byKey(const ValueKey("connectButton")));
      
      expect(find.text(WELCOME_TEXT), findsOneWidget);

    });
  });
}