import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../errors/failures/failures.dart';
import '../../../errors/failures/i_failure.dart';
import '../i_usecase.dart';

class GetCodigoFonteFromFileUsecase
    implements UseCaseSync<List<String>, NoParams> {
  @override
  Either<IFailure, List<String>> call(NoParams params) {
    try {
      List<String> codigoFonte = File('./fonte.alg').readAsLinesSync();
      codigoFonte = codigoFonte.map((e) => e += '\n').toList();
      codigoFonte.last += ' \$';
      return Right(codigoFonte);
    } catch (_) {
      return Left(
        InternalFailure(column: 0, row: 0),
      );
    }
  }
}
