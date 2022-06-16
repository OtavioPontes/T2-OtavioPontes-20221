import '../../domain/entities/token.dart';

class TokenModel extends Token {
  const TokenModel({
    required String classe,
    required String lexema,
    String? tipo,
  }) : super(
          classe: classe,
          lexema: lexema,
          tipo: tipo,
        );

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      classe: map['classe'] ?? '',
      lexema: map['lexema'] ?? '',
      tipo: map['tipo'] ?? '',
    );
  }

  Token toEntity() {
    return Token(
      classe: classe,
      lexema: lexema,
      tipo: tipo,
    );
  }
}
