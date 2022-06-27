import 'package:equatable/equatable.dart';

abstract class IFailure extends Equatable {
  final String message;
  final int? row;
  final int? column;

  const IFailure({
    this.message = '',
    this.row,
    this.column,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
