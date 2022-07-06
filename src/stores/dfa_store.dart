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
    20,
    21,
    22,
    24
  ];

  Token? pipeline({
    required String char,
    required int row,
    required int column,
  }) {
    isCharacterValid(
      char: char,
      column: column,
      row: row,
    );
    return transitState(
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
    if (!tokenStore.alfabeto.containsCharacter(char.toLowerCase()) &&
        !char.contains(RegExp(r'\s+')))
      tokenStore.addTokenToErrorList(
        failure: InvalidCharFailure(
          row: row,
          column: column,
          char: char,
        ),
      );
  }

  Token? transitState({
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
            else if (char == '\$')
              currentState = 12;
            else if (['>', '<'].contains(char))
              currentState = 13;
            else if (char == '=')
              currentState = 14;
            else if (char == '(')
              currentState = 16;
            else if (char == ')')
              currentState = 17;
            else if (char == ';')
              currentState = 18;
            else if (char == ',')
              currentState = 19;
            else if (['+', '-', '*', '/'].contains(char))
              currentState = 21;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 1:
          {
            if (tokenStore.alfabeto.digitos.contains(char))
              currentState = 1;
            else if (['e', 'E'].contains(char))
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
            else if (['e', 'E'].contains(char))
              currentState = 25;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 4:
          {
            if (tokenStore.alfabeto.digitos.contains(char))
              currentState = 6;
            else if (char == '+')
              currentState = 5;
            else if (char == '-')
              currentState = 23;
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
            else if (['>', '<', '='].contains(char))
              currentState = 22;
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
        case 21:
          throw InvalidTransitionFailure();
        case 22:
          throw InvalidTransitionFailure();
        case 23:
          {
            if (tokenStore.alfabeto.digitos.contains(char))
              currentState = 24;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 24:
          {
            if (tokenStore.alfabeto.digitos.contains(char))
              currentState = 24;
            else
              throw InvalidTransitionFailure();
          }
          break;
        case 25:
          {
            if (['+', '-'].contains(char))
              currentState = 23;
            else if (tokenStore.alfabeto.digitos.contains(char))
              currentState = 24;
            else
              throw InvalidTransitionFailure();
          }
          break;
      }
    } on InvalidTransitionFailure {
      if (finalStates.contains(currentState)) {
        tokenStore.lexemaLido = tokenStore.lexemaLido
            .substring(0, tokenStore.lexemaLido.length - 1);
        tokenStore.lexemaLido = tokenStore.lexemaLido.trim();

        Token? token = tokenStore.tabelaSimbolos[tokenStore.lexemaLido];
        if (tokenStore.hasError) {
          token = Token(
            classe: EnumTipoToken.ERRO.toFormattedString,
            lexema: tokenStore.lexemaLido,
          );

          tokenStore.addTokenToErrorList(
            failure: InvalidWordFailure(
              column: column - tokenStore.lexemaLido.length,
              row: row,
              word: tokenStore.lexemaLido,
            ),
          );

          tokenStore.hasError = false;
        } else {
          switch (currentState) {
            case 1:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.Num.toFormattedString,
                tipo: 'inteiro',
              );

              break;
            case 3:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.Num.toFormattedString,
                tipo: 'real',
              );

              break;
            case 6:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.Num.toFormattedString,
                tipo: 'inteiro',
              );

              break;
            case 8:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.Lit.toFormattedString,
                tipo: 'literal',
              );

              break;
            case 9:
              if (token == null) {
                token = Token(
                  lexema: tokenStore.lexemaLido,
                  classe: EnumTipoToken.id.toFormattedString,
                );
                tokenStore.tabelaSimbolos.addAll(
                  {tokenStore.lexemaLido: token},
                );
              }
              break;
            case 11:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.Comentario.toFormattedString,
              );

              break;
            case 12:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.EOF.toFormattedString,
              );

              break;
            case 13:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.OPR.toFormattedString,
              );

              break;
            case 14:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.OPR.toFormattedString,
              );

              break;
            case 15:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.RCB.toFormattedString,
              );

              break;
            case 16:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.AB_P.toFormattedString,
              );

              break;
            case 17:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.FC_P.toFormattedString,
              );

              break;
            case 18:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.PT_V.toFormattedString,
              );

              break;
            case 19:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.Vir.toFormattedString,
              );

              break;

            case 21:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.OPM.toFormattedString,
              );

              break;
            case 22:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.OPR.toFormattedString,
              );

              break;
            case 24:
              token ??= Token(
                lexema: tokenStore.lexemaLido,
                classe: EnumTipoToken.Num.toFormattedString,
                tipo: 'real',
              );

              break;
          }
        }
        currentState = 0;
        if (tokenStore.column > 0) tokenStore.column = tokenStore.column - 1;

        tokenStore.lexemaLido = '';
        return token;
      } else {
        tokenStore.hasError = true;
      }
    }
    return null;
  }
}
