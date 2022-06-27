import '../domain/entities/token.dart';
import '../domain/enums/enum_tipo_token.dart';
import '../errors/failures/failures.dart';
import 'token_store.dart';

class DFAStore {
  final TokenStore tokenStore;

  DFAStore({
    required this.tokenStore,
  });

  int currentState = 0;

  List<int> finalStates = [
    1,
    3,
    6,
    8,
    9,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ];

  Map<int, List<int>> transitionTable = {
    0: [0, 1, 7, 9, 10, 12, 13, 16, 17, 18, 19, 20], // Estado Inicial
    1: [1, 2, 4],
    2: [3, 20],
    3: [3, 4],
    4: [5, 6, 20],
    5: [6, 20],
    6: [6],
    7: [7, 8, 20],
    8: [],
    9: [9],
    10: [10, 11, 20],
    11: [],
    12: [],
    13: [14, 15],
    14: [],
    15: [],
    16: [],
    17: [],
    18: [],
    19: [],
    20: [], // Estado de Erro
  };

  void transitState({
    required String char,
    required int row,
    required int column,
  }) {
    try {
      tokenStore.lexemaLido += char;
      switch (currentState) {
        case 0:
          {
            if (char.contains(RegExp(r'\s+')))
              currentState = 0;
            else if (tokenStore.alfabeto.digitos.contains(char))
              currentState = 1;
            else if (char == '\"')
              currentState = 7;
            else if (tokenStore.alfabeto.letras.contains(char.toLowerCase()))
              currentState = 9;
            else if (char == '{')
              currentState = 10;
            else if (['>', '<', '='].contains(char))
              currentState = 13;
            else if (char == '(')
              currentState = 16;
            else if (char == ')')
              currentState = 17;
            else if (char == ';')
              currentState = 18;
            else if (char == ',')
              currentState = 19;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 1:
          {
            if (tokenStore.alfabeto.digitos.contains(char))
              currentState = 1;
            else if (char == '^')
              currentState = 4;
            else if (char == '.')
              currentState = 2;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 2:
          {
            if (tokenStore.alfabeto.digitos.contains(char))
              currentState = 3;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 3:
          {
            if (tokenStore.alfabeto.digitos.contains(char))
              currentState = 3;
            else if (char == '^')
              currentState = 4;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 4:
          {
            if (tokenStore.alfabeto.digitos.contains(char))
              currentState = 6;
            else if (['+', '-'].contains(char))
              currentState = 5;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 5:
          {
            if (tokenStore.alfabeto.digitos.contains(char))
              currentState = 6;
            else
              throw InvalidTransitionFailure();
          }

          break;
        case 6:
          {
            if (tokenStore.alfabeto.digitos.contains(char))
              currentState = 6;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 7:
          {
            if (char == '\"')
              currentState = 8;
            else if (char != '\"')
              currentState = 7;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 8:
          throw InvalidTransitionFailure();

        case 9:
          {
            if (tokenStore.alfabeto.digitos.contains(char))
              currentState = 9;
            else if (tokenStore.alfabeto.letras.contains(char.toLowerCase()))
              currentState = 9;
            else if (char == '_')
              currentState = 9;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 10:
          {
            if (char == '}')
              currentState = 11;
            else if (char != '}')
              currentState = 10;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 11:
          throw InvalidTransitionFailure();
        case 12:
          throw InvalidTransitionFailure();

        case 13:
          {
            if (char == '-')
              currentState = 15;
            else if (['>', '<'].contains(char))
              currentState = 14;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 14:
          throw InvalidTransitionFailure();
        case 15:
          throw InvalidTransitionFailure();
        case 16:
          throw InvalidTransitionFailure();
        case 17:
          throw InvalidTransitionFailure();
        case 18:
          throw InvalidTransitionFailure();
        case 19:
          throw InvalidTransitionFailure();
        case 20:
          throw InvalidTransitionFailure();
      }
    } on InvalidTransitionFailure catch (e) {
      if (finalStates.contains(currentState)) {
        tokenStore.lexemaLido = tokenStore.lexemaLido
            .substring(0, tokenStore.lexemaLido.length - 1);
        print(tokenStore.lexemaLido.trim());
        currentState = 0;
        tokenStore.currentPosition = tokenStore.currentPosition - 1;
        tokenStore.lexemaLido = '';
      } else {
        tokenStore.addTokenToErrorList(
          token: Token(
            classe: EnumTipoToken.ERRO.toFormattedString,
            lexema: char,
          ),
        );
      }
    }
  }

  void pipeline({
    required String char,
    required int row,
    required int column,
  }) {
    isCharacterValid(
      char: char,
      column: column,
      row: row,
    );
    transitState(
      char: char,
      column: column,
      row: row,
    );
  }

  void isCharacterValid({
    required String char,
    required int row,
    required int column,
  }) {
    tokenStore.addTokenToErrorList(
      token: Token(
        classe: EnumTipoToken.ERRO.toFormattedString,
        lexema: char,
      ),
    );
  }
}
