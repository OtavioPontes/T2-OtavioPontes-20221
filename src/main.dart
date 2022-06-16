import 'domain/usecases/scanner/get_codigo_fonte_from_file_usecase.dart';
import 'domain/usecases/tokens/get_tokens_from_palavras_reservadas_usecase.dart';
import 'stores/scanner_store.dart';
import 'stores/token_store.dart';

void main() async {
  final TokenStore tokenStore = TokenStore(
    getTokensFromPalavrasReservadasUsecase:
        GetTokensFromPalavrasReservadasUsecase(),
  );
  final ScannerStore scannerStore = ScannerStore(
    tokenStore: tokenStore,
    getCodigoFonteFromFileUsecase: GetCodigoFonteFromFileUsecase(),
  );
}
