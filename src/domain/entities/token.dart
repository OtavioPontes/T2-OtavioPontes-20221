import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String classe;
  final String lexema;
  final String? tipo;
  const Token({
    required this.classe,
    required this.lexema,
    this.tipo,
  });

  Token copyWith({
    String? classe,
    String? lexema,
    String? tipo,
  }) {
    return Token(
      classe: classe ?? this.classe,
      lexema: lexema ?? this.lexema,
      tipo: tipo ?? this.tipo,
    );
  }

  @override
  List<Object?> get props => [
        classe,
        lexema,
        tipo,
      ];
}
