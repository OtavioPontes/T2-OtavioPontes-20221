import 'dart:io';

import '../data/models/alfabeto_model.dart';
import '../domain/entities/token.dart';
import '../domain/usecases/i_usecase.dart';
import '../domain/usecases/tokens/get_tokens_from_palavras_reservadas_usecase.dart';
import '../errors/failures/i_failure.dart';

class TokenStore {
  final GetTokensFromPalavrasReservadasUsecase
      getTokensFromPalavrasReservadasUsecase;

  TokenStore({
    required this.getTokensFromPalavrasReservadasUsecase,
  }) {
    pipeline();
  }

  int column = 1;
  int row = 1;
  int currentPosition = 0;

  late AlfabetoModel alfabeto;

  List<IFailure> erros = [];

  Map<String, Token> tabelaSimbolos = {};

  bool hasError = false;
  String lexemaLido = '';

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
    alfabeto = AlfabetoModel.fromJson(
      File('./alfabeto.json').readAsStringSync(),
    );
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

  void addTokenToErrorList({required IFailure failure}) {
    erros.add(failure);
  }

  void updateToken({required Token token}) {
    tabelaSimbolos[token.lexema] = token;
  }

  Token? getTokenFromLexema({required Token token}) {
    return tabelaSimbolos[token.lexema];
  }
}
