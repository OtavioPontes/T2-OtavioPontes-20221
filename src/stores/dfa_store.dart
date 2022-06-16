import 'token_store.dart';

class DFAStore {
  final TokenStore tokenStore;
  DFAStore({
    required this.tokenStore,
  });

  bool isCharacterValid({required String char}) {
    return tokenStore.alfabeto.contains(char);
  }
}
