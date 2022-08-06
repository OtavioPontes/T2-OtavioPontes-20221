import '../enums/enum_actions.dart';

class Action {
  final EnumActions type;
  final int? state;

  Action({
    required this.type,
    this.state,
  });

  @override
  String toString() => 'Action(action: $type, state: $state)';
}
