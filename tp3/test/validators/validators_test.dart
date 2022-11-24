import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/validators/validators.dart';

main() {
  group('Validators - validateBasicField', () {
    test("Si null, retourne un message d'erreur", () {
      var errorMessage = Validators.validateBasicField(null);

      expect(errorMessage, equals(tr(LocaleKeys.login_user_not_empty)));
    });
    test("Si vide, retourne un message d'erreur", () {
      var errorMessage = Validators.validateBasicField("");

      expect(errorMessage, equals(tr(LocaleKeys.login_user_not_empty)));
    });
    test("Si valide, retourne null", () {
      var errorMessage = Validators.validateBasicField("a");

      expect(errorMessage, isNull);
    });
  });
  group('Validators - validateEmail', () {
    test("Si null, retourne un message d'erreur", () {
      var errorMessage = Validators.validateEmail(null);

      expect(errorMessage, equals(tr(LocaleKeys.login_user_not_empty)));
    });
    test("Si vide, retourne un message d'erreur", () {
      var errorMessage = Validators.validateEmail("");

      expect(errorMessage, equals(tr(LocaleKeys.login_user_not_empty)));
    });
    test("Si email invalide, retourne un message d'erreur #1", () {
      var errorMessage = Validators.validateEmail("a");

      expect(errorMessage, equals(tr(LocaleKeys.login_user_email_invalid)));
    });
    test("Si email invalide, retourne un message d'erreur #2", () {
      var errorMessage = Validators.validateEmail("a@a");

      expect(errorMessage, equals(tr(LocaleKeys.login_user_email_invalid)));
    });
    test("Si email invalide, retourne un message d'erreur #3", () {
      var errorMessage = Validators.validateEmail("a@a.");

      expect(errorMessage, equals(tr(LocaleKeys.login_user_email_invalid)));
    });
    test("Si email invalide, retourne un message d'erreur #4", () {
      var errorMessage = Validators.validateEmail("@a.ca");

      expect(errorMessage, equals(tr(LocaleKeys.login_user_email_invalid)));
    });
    test("Si email invalide, retourne un message d'erreur #5", () {
      var errorMessage = Validators.validateEmail("a@.ca");

      expect(errorMessage, equals(tr(LocaleKeys.login_user_email_invalid)));
    });
    test("Si valide, retourne null", () {
      var errorMessage = Validators.validateEmail("a@a.ca");

      expect(errorMessage, isNull);
    });
  });
  group('Validators - validatePassword', () {
    test("Si null, retourne un message d'erreur", () {
      var errorMessage = Validators.validatePassword(null);

      expect(errorMessage, equals(tr(LocaleKeys.login_user_not_empty)));
    });
    test("Si vide, retourne un message d'erreur", () {
      var errorMessage = Validators.validatePassword("");

      expect(errorMessage, equals(tr(LocaleKeys.login_user_not_empty)));
    });
    test("Si trop petit, retourne un message d'erreur", () {
      var errorMessage = Validators.validatePassword("1234");

      expect(errorMessage, equals(tr(LocaleKeys.login_user_password_short)));
    });
    test("Si valide, retourne null", () {
      var errorMessage = Validators.validatePassword("12345");

      expect(errorMessage, isNull);
    });
  });
}