import 'dart:io';

import '../domain/entities/token.dart';
import '../domain/usecases/i_usecase.dart';
import '../domain/usecases/tokens/get_tokens_from_palavras_reservadas_usecase.dart';

class TokenStore {
  final GetTokensFromPalavrasReservadasUsecase
      getTokensFromPalavrasReservadasUsecase;

  TokenStore({
    required this.getTokensFromPalavrasReservadasUsecase,
  }) {
    pipeline();
  }
  List<String> alfabeto = [];

  Map<String, Token> tabelaSimbolos = {};

  void pipeline() async {
    final List<Token> tokensFromPalavrasReservadas =
        getTokensFromPalavrasReservadas();
    tabelaSimbolos.addEntries(
      tokensFromPalavrasReservadas.map(
        (e) => MapEntry(
          e.lexema,
          e,
        ),
      ),
    );
    alfabeto = File('./alfabeto.txt').readAsStringSync().trim().split(',');
  }

  List<Token> getTokensFromPalavrasReservadas() {
    return handleUseCaseSync(
      getTokensFromPalavrasReservadasUsecase,
      NoParams(),
    );
  }

  void addTokenToTable({required Token token}) {
    tabelaSimbolos.addAll(
      {
        token.lexema: token,
      },
    );
  }

  void updateToken({required Token token}) {
    tabelaSimbolos[token.lexema] = token;
  }

  Token? getTokenFromLexema({required Token token}) {
    return tabelaSimbolos[token.lexema];
  }
}
