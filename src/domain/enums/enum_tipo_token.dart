import '../../errors/failures/failures.dart';

enum EnumTipoToken {
  Num,
  Lit,
  id,
  Comentario,
  EOF,
  OPR,
  RCB,
  OPM,
  AB_P,
  FC_P,
  PT_V,
  ERRO,
  Vir,
  Ignorar
}

extension ExtensionEnumTipoToken on EnumTipoToken {
  String get toFormattedString {
    switch (this) {
      case EnumTipoToken.Num:
        return 'Num';
      case EnumTipoToken.Lit:
        return 'Lit';
      case EnumTipoToken.id:
        return 'id';
      case EnumTipoToken.Comentario:
        return 'Comentario';
      case EnumTipoToken.EOF:
        return 'EOF';
      case EnumTipoToken.OPR:
        return 'OPR';
      case EnumTipoToken.RCB:
        return 'RCB';
      case EnumTipoToken.AB_P:
        return 'AB_P';
      case EnumTipoToken.FC_P:
        return 'FC_P';
      case EnumTipoToken.PT_V:
        return 'PT_V';
      case EnumTipoToken.ERRO:
        return 'ERRO';
      case EnumTipoToken.Vir:
        return 'Vir';
      case EnumTipoToken.Ignorar:
        return 'Ignorar';

      default:
        throw Exception();
    }
  }
}
