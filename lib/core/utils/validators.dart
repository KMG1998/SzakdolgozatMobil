class Validators {
  static String? emailValidator(String? email) {
    if (email?.isEmpty ?? true) {
      return "Kötelező mező";
    }
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email!)
        ? null
        : "Érvénytelen formátum";
  }

  static String? passwordValidator(String? password) {
    if (password?.isEmpty ?? true) {
      return "Kötelező mező";
    }
    return password!.length >= 8 ? null : "Legalább 8 karakter hosszúnak kell lennie";
  }

  static String? nameValidator(String? name) {
    if (name?.isEmpty ?? true) {
      return "Kötelező mező";
    }
    return name!.length >= 3 ? null : "Legalább 3 karakter hosszúnak kell lennie";
  }

  static String? passwordAgainValidator(String? password, String? passwordAgain) {
    if (password?.isEmpty ?? true) {
      return "Kötelező mező";
    }
    if (password!.length < 8) {
      return "Legalább 8 karakter hosszúnak kell lennie";
    }
    if (password != passwordAgain) {
      return "A jelszó és az ismétlés nem egyezik";
    }
    return null;
  }
}
