import 'dart:io';

import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;

import '../../errors/failures/failures.dart';
import '../../errors/failures/i_failure.dart';
import 'i_usecase.dart';

class GetGoToFromCsvUsecase extends UseCaseSync<List<List<String>>, NoParams> {
  @override
  Either<IFailure, List<List<String>>> call(NoParams params) {
    try {
      final String goToCsvString = File(
        path.joinAll(
          [
            '..\\',
            'T2-OtavioPontes-20221',
            'assets',
            'goto.csv',
          ],
        ),
      ).readAsStringSync();
      final List<List<String>> rowsAsListOfValues = const CsvToListConverter()
          .convert(goToCsvString,
              shouldParseNumbers: false, fieldDelimiter: ';');
      return Right(rowsAsListOfValues);
    } catch (_) {
      return Left(
        InternalFailure(),
      );
    }
  }
}
