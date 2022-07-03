import '../domain/entities/token.dart';
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

  late String codigoFonte;

  void pipeline() async {
    codigoFonte = getCodigoFonte();
  }

  String getCodigoFonte() {
    return handleUseCaseSync(
      getCodigoFonteFromFileUsecase,
      NoParams(),
    );
  }

  Future<Token?> scanner({required String codigoFonte}) async {
    final int codigoFonteLength = codigoFonte.length;

    while (tokenStore.currentPosition < codigoFonteLength) {
      final Token? token = dfaStore.pipeline(
        char: codigoFonte[tokenStore.currentPosition],
        row: tokenStore.row,
        column: tokenStore.column,
      );
      tokenStore.currentPosition++;

      // if (token != null) return token;
      continue;
    }
    if (tokenStore.lexemaLido.isNotEmpty) {
      tokenStore.addTokenToErrorList(
        failure: InvalidWordFailure(
          row: tokenStore.row,
          column: tokenStore.column,
          word: tokenStore.lexemaLido,
        ),
      );
    }
  }
}
