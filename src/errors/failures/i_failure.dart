import 'package:equatable/equatable.dart';

abstract class IFailure extends Equatable {
  final int? row;
  final int? column;
  final String? char;

  const IFailure({
    this.char,
    this.row,
    this.column,
  });

  @override
  List<Object?> get props => [
        row,
        column,
        char,
      ];
}
