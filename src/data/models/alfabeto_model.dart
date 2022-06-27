import 'dart:convert';

class AlfabetoModel {
  final List<String> digitos;
  final List<String> letras;
  final List<String> operadores;
  final List<String> operadoresIgualdade;
  AlfabetoModel({
    required this.digitos,
    required this.letras,
    required this.operadores,
    required this.operadoresIgualdade,
  });

  Map<String, dynamic> toMap() {
    return {
      'digitos': digitos,
      'letras': letras,
      'operadores': operadores,
      'operadoresIgualdade': operadoresIgualdade,
    };
  }

  bool containsCharacter(String char) {
    return digitos.contains(char) ||
        letras.contains(char) ||
        operadores.contains(char) ||
        operadoresIgualdade.contains(char);
  }

  factory AlfabetoModel.fromMap(Map<String, dynamic> map) {
    return AlfabetoModel(
      digitos: List<String>.from(map['digitos']),
      letras: List<String>.from(map['letras']),
      operadores: List<String>.from(map['operadores']),
      operadoresIgualdade: List<String>.from(map['operadores_igualdade']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AlfabetoModel.fromJson(String source) =>
      AlfabetoModel.fromMap(json.decode(source));
}
