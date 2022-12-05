import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tp3/main.dart' as app;
import 'package:tp3/utils/constants.dart';

void main() {
  Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  if (binding is LiveTestWidgetsFlutterBinding) {
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  }
   group('Login page test', () {
    
    testWidgets('With good credential, logs you in and sends you to the welcome view',
        (tester) async {
      app.main();
     

      Random random = Random();
      int number = random.nextInt(4294967296);

      String nameSignUp = "Celmar$number";
      String emailSignUp = "test$number@hotmail.com";
      String passwordSignUp = "$number";

       String email = emailSignUp;
      String password = passwordSignUp;

      

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey("noAccountButton")));
      await addDelay(2000);

      await tester.enterText(find.byKey(const ValueKey('nameSignUpKey')), nameSignUp);
      await tester.enterText(find.byKey(const ValueKey('emailSignUpKey')), emailSignUp);
      await tester.enterText(find.byKey(const ValueKey('passwordSignUpKey')), passwordSignUp);
      await addDelay(2000);
      await tester.tap(find.byKey(const ValueKey("termsAndConditionSignUpKey")));
      await addDelay(2000);
      await tester.tap(find.byKey(const ValueKey("createAccountButton")));
      await addDelay(2000);
      await tester.pumpAndSettle();

      expect(find.text(WELCOME_TEXT), findsOneWidget);
      await addDelay(2000);
      await tester.pumpAndSettle(); 
      await addDelay(2000);
      await tester.tap(find.byTooltip('Ouvrir le menu de navigation'));
      await addDelay(2000);
      await tester.tap(find.byKey(const ValueKey('disconnectButton')));

      await tester.pumpAndSettle(); 
      expect(find.text(CONNECTION_LABEL), findsOneWidget);

      await tester.pumpAndSettle();
      
      await tester.enterText(find.byKey(const ValueKey('emailSignInField')), email);
      await tester.enterText(find.byKey(const ValueKey('passwordSignInField')), password);

      await tester.tap(find.byKey(const ValueKey("connectButton")));
      await tester.pumpAndSettle(); 

      
      await tester.pumpAndSettle(); 
      await addDelay(2000);
      await tester.tap(find.text(STATIONS));
      await addDelay(2000);

       expect(find.text(STATIONS_LABEL), findsOneWidget);

       // POUR DÉCONNECTER POUR ÊTRE CAPABLE DE LES ROULER À L'INFINI
      await addDelay(2000);
      await tester.pumpAndSettle(); 
      await addDelay(2000);
      await tester.tap(find.byTooltip('Ouvrir le menu de navigation'));
      await addDelay(2000);
      await tester.tap(find.byKey(const ValueKey('disconnectButton')));

      await tester.pumpAndSettle(); 
      await addDelay(2000);
      expect(find.text(CONNECTION_LABEL), findsOneWidget);
    });
  }); 
  
}