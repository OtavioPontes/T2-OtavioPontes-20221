import '../../errors/failures/failures.dart';
import '../entities/action_entity.dart';

enum EnumActions {
  shift,
  reduce,
  accept,
}

extension ExtensionEnumTipoToken on EnumActions {
  bool get isShift => this == EnumActions.shift;
  bool get isReduce => this == EnumActions.reduce;
  bool get isAccept => this == EnumActions.accept;
}

class UtilsEnumActions {
  static Action fromString(String action) {
    if (action.startsWith('s')) {
      final List<String> actionSteps = action.split('s');
      return Action(
        type: EnumActions.shift,
        state: int.parse(actionSteps.last),
      );
    }
    if (action.startsWith('r')) {
      final List<String> reduceSteps = action.split('r');
      return Action(
        type: EnumActions.reduce,
        state: int.parse(reduceSteps.last),
      );
    }
    if (action == 'acc') {
      return Action(
        type: EnumActions.accept,
      );
    }
    throw InternalFailure();
  }
}
