import 'domain/usecases/scanner/get_codigo_fonte_from_file_usecase.dart';
import 'domain/usecases/tokens/get_tokens_from_palavras_reservadas_usecase.dart';
import 'errors/failures/failures.dart';
import 'stores/dfa_store.dart';
import 'stores/scanner_store.dart';
import 'stores/token_store.dart';

void main() async {
  final TokenStore tokenStore = TokenStore(
    getTokensFromPalavrasReservadasUsecase:
        GetTokensFromPalavrasReservadasUsecase(),
  );
  final DFAStore dfaStore = DFAStore(tokenStore: tokenStore);

  final ScannerStore scannerStore = ScannerStore(
    dfaStore: dfaStore,
    tokenStore: tokenStore,
    getCodigoFonteFromFileUsecase: GetCodigoFonteFromFileUsecase(),
  );
  await scannerStore.scanner(codigoFonte: scannerStore.codigoFonte);
  print('Tokens:');
  tokenStore.tabelaSimbolos.values.forEach(print);
  print('\nErros:');
  tokenStore.erros.forEach(
    (element) => {
      if (element is InvalidCharFailure)
        {
          print(
              '[Erro Léxico] - (${element.char}) Caractére Inválido na linha ${element.row! + 1} e coluna ${element.column! + 1}')
        }
      else if (element is InvalidWordFailure)
        {
          print(
              '[Erro Léxico] - (${element.char}) Palavra Rejeitada na linha ${element.row! + 1} e coluna ${element.column! + 1}')
        }
    },
  );
}
