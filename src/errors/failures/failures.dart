import 'i_failure.dart';

class InternalFailure extends IFailure {
  const InternalFailure({
    required int row,
    required int column,
  }) : super(
          column: column,
          row: row,
        );
}

class InvalidCharFailure extends IFailure {
  const InvalidCharFailure({
    required int row,
    required int column,
    required String char,
  }) : super(
          column: column,
          row: row,
          char: char,
        );
}

class InvalidTransitionFailure extends IFailure {}

class InvalidWordFailure extends IFailure {
  const InvalidWordFailure({
    required int row,
    required int column,
    required String word,
  }) : super(
          column: column,
          row: row,
          char: word,
        );
}
