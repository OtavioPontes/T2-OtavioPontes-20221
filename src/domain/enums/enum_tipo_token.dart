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
      case EnumTipoToken.OPM:
        return 'OPM';

      default:
        throw Exception();
    }
  }
}

class UtilsEnumTipoToken {
  EnumTipoToken getTokenByState(int state) {
    switch (state) {
      case 1:
        return EnumTipoToken.Num;
      case 8:
        return EnumTipoToken.Lit;
      case 9:
        return EnumTipoToken.id;
      case 11:
        return EnumTipoToken.Comentario;
      case 12:
        return EnumTipoToken.EOF;
      case 14:
        return EnumTipoToken.OPR;
      case 15:
        return EnumTipoToken.RCB;
      case 16:
        return EnumTipoToken.AB_P;
      case 17:
        return EnumTipoToken.FC_P;
      case 18:
        return EnumTipoToken.PT_V;
      case 19:
        return EnumTipoToken.Vir;

      case 22:
        return EnumTipoToken.OPM;
      default:
        throw Exception();
    }
  }
}
