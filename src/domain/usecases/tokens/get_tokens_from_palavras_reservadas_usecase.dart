import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../data/models/token_model.dart';
import '../../../errors/failures/failures.dart';
import '../../../errors/failures/i_failure.dart';
import '../../../main.dart';
import '../../entities/token.dart';
import '../i_usecase.dart';

class GetTokensFromPalavrasReservadasUsecase
    extends UseCaseSync<List<Token>, NoParams> {
  @override
  Either<IFailure, List<Token>> call(params) {
    try {
      final List<dynamic> jsonPalavrasReservadas = json.decode(
        File('./palavras_reservadas.json').readAsStringSync(),
      );

      final List<Token> tokensFromPalavrasReservadas = List.generate(
        jsonPalavrasReservadas.length,
        (index) => TokenModel.fromMap(
          jsonPalavrasReservadas[index],
        ).toEntity(),
      );

      return Right(tokensFromPalavrasReservadas);
    } catch (_) {
      return Left(
        InternalFailure(
          column: 0,
          row: 0,
        ),
      );
    }
  }
}
