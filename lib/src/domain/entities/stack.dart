class Stack<T> {
  final _list = <T>[];

  Stack([T? value]) {
    if (value != null) push(value);
  }

  void push(T value) => _list.add(value);

  T pop() => _list.removeLast();

  T get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}
