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
}
