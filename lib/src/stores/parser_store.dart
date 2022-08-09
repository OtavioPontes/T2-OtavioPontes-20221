import 'package:analisador_lexico/analisador_lexico.dart';

import '../domain/entities/action_entity.dart';
import '../domain/entities/stack.dart';
import '../domain/enums/enum_actions.dart';
import '../errors/failures/failures.dart';
import 'table_store.dart';

class ParserStore {
  final TableStore tableStore;
  final ScannerStore scannerStore;
  final TokenStore tokenStore;
  ParserStore({
    required this.tableStore,
    required this.scannerStore,
    required this.tokenStore,
  });
  Stack<int> parserStack = Stack(0);

  Token? currentToken;

  bool isOver = false;

  Token? get nextToken => scannerStore.scanner(
        codigoFonte: scannerStore.codigoFonte,
        rowPar: tokenStore.row,
        columnPar: tokenStore.column,
      );

  void setNextToken() {
    currentToken = nextToken;
  }

  void parse() {
    setNextToken();
    while (!isOver) {
      try {
        final int indexColumn = tableStore.tableActions[0].indexWhere(
            (element) =>
                element.toUpperCase() == currentToken?.classe.toUpperCase());
        final String actionString =
            tableStore.tableActions[parserStack.peek + 1][indexColumn];

        final Action action = UtilsEnumActions.fromString(actionString);

        if (action.type.isShift) {
          parserStack.push(action.state!);
          setNextToken();
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
          try {
            final String stateString =
                tableStore.tableGoTo[parserStack.peek + 1][indexColumnGoTo];
            parserStack.push(
              int.parse(
                stateString,
              ),
            );
            print('${tableStore.grammar[action.state!]}');
          } catch (e) {
            throw GoToEmptyFailure();
          }
        }

        if (action.type.isAccept) {
          isOver = true;
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
