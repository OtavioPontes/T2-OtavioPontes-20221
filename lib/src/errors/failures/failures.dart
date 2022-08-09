import 'package:analisador_sintatico/src/errors/failures/i_failure.dart';

class InternalFailure extends IFailure {
  const InternalFailure();
}

class ActionEmptyFailure extends IFailure {
  const ActionEmptyFailure();
}

class GoToEmptyFailure extends IFailure {
  const GoToEmptyFailure();
}
