import 'package:flutter_test/flutter_test.dart';
import 'package:tp3/utils/maybe.dart';

main() {
  group('MayBe - hasValue', () {
    test('lorsque MayBe est vide, hasValue doit être faux', () {
      var maybe = MayBe.empty();

      expect(maybe.hasValue(), isFalse);
    });
    test('lorsque MayBe contient une valeur, hasValue doit être vrai', () {
      var maybe = MayBe("une valeur");

      expect(maybe.hasValue(), isTrue);
    });
  });
  group('MayBe - value', () {
    test('lorsque MayBe contient une valeur, value doit être cette valeur.',
        () {
      const uneValeur = "une valeur";
      var maybe = MayBe(uneValeur);

      expect(maybe.value, equals(uneValeur));
    });
    test('lorsque MayBe est vide, value doit lancer une exception.', () {
      var maybe = MayBe.empty();

      expect(() => maybe.value, throwsStateError);
    });
  });
  group('MayBe - warning', () {
    test('par défaut, warning est null.', () {
      var maybe = MayBe.empty();

      expect(maybe.warning, null);
    });
    test('quand on donne un warning, le maybe guarde cette valeur.', () {
      var maybe = MayBe.empty();
      maybe.setWarning("a");
      expect(maybe.warning, "a");
    });
    test('quand on clear de warning, le warning est null.', () {
      var maybe = MayBe.empty();
      maybe.setWarning("a");
      maybe.clearWarning();
      expect(maybe.warning, null);
    });
  });
}
