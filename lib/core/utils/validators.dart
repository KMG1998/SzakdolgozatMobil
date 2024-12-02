class Validators{
  static String? emailValidator(String? email){
    if(email?.isEmpty ?? true){
      return "Kötelező mező";
    }
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email!) ? null : "Érvénytelen formátum";
  }
  static String? passwordValidator(String? password){
    if(password?.isEmpty ?? true){
      return "Kötelező mező";
    }
    return password!.length >= 8 ? null : "Legalább 8 karakter hosszúnak kell lennie";
  }
}