import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../errors/failures/failures.dart';
import '../../../errors/failures/i_failure.dart';
import '../i_usecase.dart';

class GetCodigoFonteFromFileUsecase implements UseCaseSync<String, NoParams> {
  @override
  Either<IFailure, String> call(NoParams params) {
    try {
      final String codigoFonte = File('./fonte.alg').readAsStringSync().trim();
      return Right(codigoFonte);
    } catch (_) {
      return Left(
        InternalFailure(column: 0, row: 0),
      );
    }
  }
}
