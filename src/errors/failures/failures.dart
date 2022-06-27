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

class InvalidCharFailure extends IFailure {
  const InvalidCharFailure({
    String message = '[Erro Léxico] - Caractére inválido',
    required int row,
    required int column,
  }) : super(
          column: column,
          row: row,
          message: message,
        );
}

class InvalidTransitionFailure extends IFailure {
  const InvalidTransitionFailure({
    String message = '[Erro Léxico] - Transição inválida',
  }) : super(message: message);
}
