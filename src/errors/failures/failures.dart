import 'i_failure.dart';

class InternalFailure extends IFailure {
  const InternalFailure({
    String message = 'Houve uma Falha Interna',
    required int row,
    required int column,
  }) : super(
          column: column,
          row: row,
          message: message,
        );
}
