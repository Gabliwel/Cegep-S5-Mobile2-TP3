import 'dart:developer';

class MayBe<T> {
  final List<T> _values = [];
  String? _warning;
  int? statusCode;

  T get value => _values.first;
  String? get warning => _warning;

  MayBe.empty() {
    //
  }

  MayBe(T value) {
    _values.add(value);
  }

  setWarning(String warning) {
    _warning = warning;
  }

  clearWarning() {
    _warning = null;
  }

  bool hasValue() {
    if (_values.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
