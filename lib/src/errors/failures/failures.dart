import 'i_failure.dart';

class InternalFailure extends IFailure {
  const InternalFailure();
}

class ActionEmptyFailure extends IFailure {
  const ActionEmptyFailure({
    required String char,
    required int row,
    required int column,
  }) : super(
          char: char,
          column: column,
          row: row,
        );
  @override
  String toString() =>
      '[ActionFailure] Sem saída para \'$char\', linha: $row, coluna: $column';
}

class GoToEmptyFailure extends IFailure {
  final String leftSide;
  final int state;
  const GoToEmptyFailure({
    required this.leftSide,
    required this.state,
  });
  @override
  String toString() =>
      '[GoToFailure] Sem saída para \'$leftSide\' com estado $state';
}
