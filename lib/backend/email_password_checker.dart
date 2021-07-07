class EmailPasswordChecker {
  final String email;
  final String password;

  EmailPasswordChecker({required this.email, required this.password});

  bool checkUserEmail() {
    return email.contains(RegExp(r'^[\w]+@[a-zA-Z]+.(com|co.uk)$'));
  }

  bool checkPasswordLength() {
    return password.length >= 6;
  }
}
