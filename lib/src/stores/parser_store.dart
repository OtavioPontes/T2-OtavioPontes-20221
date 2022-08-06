import 'package:analisador_lexico/analisador_lexico.dart';

import '../domain/entities/action_entity.dart';
import '../domain/entities/stack.dart';
import '../domain/enums/enum_actions.dart';
import 'table_store.dart';

class ParserStore {
  final TableStore tableStore;
  ParserStore({
    required this.tableStore,
  });
  Stack<int> parserStack = Stack(0);
  bool isOver = false;

  void parse({required Token token}) {
    try {
      final int indexColumn = tableStore.tableActions[0].indexWhere(
          (element) => element.toUpperCase() == token.classe.toUpperCase());
      final String actionString =
          tableStore.tableActions[parserStack.peek + 1][indexColumn];
      final Action action = UtilsEnumActions.fromString(actionString);

      if (action.type.isShift) {
        parserStack.push(action.state!);
      }
      if (action.type.isReduce) {
        final int rightLegth =
            tableStore.grammar[action.state!].rightSide.split(' ').length;

        for (int i = 0; i < rightLegth; i++) {
          parserStack.pop();
        }
        final int indexColumnGoTo = tableStore.tableGoTo[0].indexWhere(
          (element) =>
              element.toUpperCase() ==
              tableStore.grammar[action.state!].leftSide.toUpperCase(),
        );
        parserStack.push(
          int.parse(
            tableStore.tableGoTo[parserStack.peek + 1][indexColumnGoTo],
          ),
        );
        print(tableStore.grammar[action.state!]);
      }
      if (action.type.isAccept) {
        isOver = true;
      }
    } catch (e) {
      print(e);
    }
  }
}
