class MayBe<T> {
  final List<T> _values = [];

  T get value => _values.first;

  MayBe.empty() {
    //
  }

  MayBe(T value) {
    _values.add(value);
  }

  bool hasValue() {
    if (_values.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
