class Validators{
  static String? emailValidator(String? email){
    if(email?.isEmpty ?? true){
      return "Please provide an e-mail address!";
    }
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email!) ? null : "Invalid e-mail format.";
  }
  static String? passwordValidator(String? password){
    if(password?.isEmpty ?? true){
      return "Please provide a password!";
    }
    return password!.length >= 8 ? null : "Password must be at least 8 characters!";
  }
}