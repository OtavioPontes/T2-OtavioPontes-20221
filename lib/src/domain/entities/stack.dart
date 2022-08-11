class Stack<T> {
  final list = <T>[];

  Stack([T? value]) {
    if (value != null) push(value);
  }

  void push(T value) => list.add(value);

  T pop() => list.removeLast();

  T get peek => list.last;

  bool get isEmpty => list.isEmpty;
  bool get isNotEmpty => list.isNotEmpty;

  @override
  String toString() => list.toString();
}
