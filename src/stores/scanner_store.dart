import '../domain/entities/token.dart';
import '../domain/usecases/i_usecase.dart';
import '../domain/usecases/scanner/get_codigo_fonte_from_file_usecase.dart';
import 'token_store.dart';

class ScannerStore {
  final GetCodigoFonteFromFileUsecase getCodigoFonteFromFileUsecase;
  final TokenStore tokenStore;

  ScannerStore({
    required this.tokenStore,
    required this.getCodigoFonteFromFileUsecase,
  }) {
    pipeline();
  }
  int column = 0;
  int row = 0;

  late String codigoFonte;
  String tokenLido = '';

  void pipeline() async {
    codigoFonte = getCodigoFonte();
  }

  Future<Token?> scanner({required int row, required int column}) async {}

  String getCodigoFonte() {
    return handleUseCaseSync(
      getCodigoFonteFromFileUsecase,
      NoParams(),
    );
  }
}
