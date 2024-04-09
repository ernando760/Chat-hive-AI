enum TypeFirebaseAuthError {
  emailAlready,
  insufficientPermission,
}

class FirebaseAuthErrorCode {
  static final _codes = {
    "invalid-credential":
        "A credencial usada para autenticar os Admin SDKs não pode ser usada para executar a ação desejada.",
    "email-already-in-use": "O e-mail já existe.",
    "invalid-email": "O email está inválido.",
    "invalid-password": "A senha está invalido.",
    "user-not-found": "O usuário não está cadastrado.",
    "network-request-failed":
        "Falha de conexão de internet, por favor tente mais tarde."
  };

  static String fromCode(String code) {
    if (_codes.containsKey(code)) {
      return _codes[code]!;
    }
    return "";
  }
}
