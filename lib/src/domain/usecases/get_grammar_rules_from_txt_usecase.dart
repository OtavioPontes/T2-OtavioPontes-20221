import 'dart:io';

import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;

import '../../errors/failures/failures.dart';
import '../../errors/failures/i_failure.dart';
import '../entities/grammar_entity.dart';
import 'i_usecase.dart';

class GetGrammarRulesFromTxtUsecase
    extends UseCaseSync<List<GrammarRule>, NoParams> {
  @override
  Either<IFailure, List<GrammarRule>> call(NoParams params) {
    try {
      final List<String> rulesString = File(
        path.joinAll(
          [
            '..\\',
            'T2-OtavioPontes-20221',
            'assets',
            'gramatica.txt',
          ],
        ),
      ).readAsLinesSync();
      final List<GrammarRule> listRules = [];
      rulesString.forEach(
        (element) {
          final List<String> sides = element.split('->');
          listRules.add(
            GrammarRule(
              leftSide: sides.first.trim(),
              rightSide: sides.last.trim(),
            ),
          );
        },
      );

      return Right(listRules);
    } catch (_) {
      return Left(
        InternalFailure(),
      );
    }
  }
}
