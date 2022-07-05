import '../domain/entities/token.dart';
import '../domain/enums/enum_tipo_token.dart';
import '../domain/usecases/i_usecase.dart';
import '../domain/usecases/scanner/get_codigo_fonte_from_file_usecase.dart';
import '../errors/failures/failures.dart';
import 'dfa_store.dart';
import 'token_store.dart';

class ScannerStore {
  final GetCodigoFonteFromFileUsecase getCodigoFonteFromFileUsecase;
  final TokenStore tokenStore;
  final DFAStore dfaStore;

  ScannerStore({
    required this.dfaStore,
    required this.tokenStore,
    required this.getCodigoFonteFromFileUsecase,
  }) {
    pipeline();
  }

  late List<String> codigoFonte;

  void pipeline() async {
    codigoFonte = getCodigoFonte();
  }

  List<String> getCodigoFonte() {
    return handleUseCaseSync(
      getCodigoFonteFromFileUsecase,
      NoParams(),
    );
  }

  Future<Token?> scanner({
    required List<String> codigoFonte,
    int? rowPar,
    int? columnPar,
  }) async {
    if (rowPar != null) tokenStore.row = rowPar;
    if (columnPar != null) tokenStore.column = columnPar;

    while (codigoFonte[tokenStore.row][tokenStore.column] != '\$') {
      final Token? token = dfaStore.pipeline(
        char: codigoFonte[tokenStore.row][tokenStore.column],
        row: tokenStore.row,
        column: tokenStore.column,
      );

      if (tokenStore.column == codigoFonte[tokenStore.row].length - 1) {
        tokenStore.row++;
        tokenStore.column = 0;
      } else
        tokenStore.column++;
      if (token != null) return token;
    }

    if (tokenStore.lexemaLido.trim().isNotEmpty) {
      tokenStore.addTokenToErrorList(
        failure: InvalidWordFailure(
          row: tokenStore.row,
          column: tokenStore.column,
          word: tokenStore.lexemaLido.trim(),
        ),
      );
      final Token token = Token(
        classe: EnumTipoToken.ERRO.toFormattedString,
        lexema: tokenStore.lexemaLido.trim(),
      );
      tokenStore.lexemaLido = '';
      return token;
    }
    tokenStore.isOver = true;

    return Token(
      classe: EnumTipoToken.EOF.toFormattedString,
      lexema: '\$',
    );
  }
}
