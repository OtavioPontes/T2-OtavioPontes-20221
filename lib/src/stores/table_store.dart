import '../domain/entities/grammar_entity.dart';
import '../domain/usecases/get_actions_from_csv_usecase.dart';
import '../domain/usecases/get_go_to_from_csv_usecase.dart';
import '../domain/usecases/get_grammar_rules_from_txt_usecase.dart';
import '../domain/usecases/i_usecase.dart';

class TableStore {
  final List<GrammarRule> grammar = handleUseCaseSync(
    GetGrammarRulesFromTxtUsecase(),
  );
  final List<List<String>> tableGoTo = handleUseCaseSync(
    GetGoToFromCsvUsecase(),
  );
  final List<List<String>> tableActions = handleUseCaseSync(
    GetActionsFromCsvUsecase(),
  );
}
