class EmailPasswordChecker {
  final String email;
  final String password;

  EmailPasswordChecker({required this.email, required this.password});

  bool checkUserEmail() {
    /**
     * Check the email address
     *
     * Check that the provide email address follows the Regular Expression
     * provided, this is a very simple approach as it allows email address
     * ending in ".com" or ".co.uk".
     *
     * This would have ideally be handled by Firebase Authentication. Though
     * ran out of time so added this simple rule.
     *
     * :param email (String): the email address entered by the user
     *
     * :return (bool): whether the email provided abides by the basic RegEx rule
     */
    return email.contains(RegExp(r'^[\w]+@[a-zA-Z]+.(com|co.uk)$'));
  }

  bool checkPasswordLength() {
    /**
     * Check the Password provided
     *
     * Check that the provided Password has a length of >= 6. More
     * complex rules can be added, such as not allowing certain characters,
     * E.g. whitespaces.
     *
     * Ideally this would also be handled by Firebase Authentication.
     *
     * :param password (String): the password provided by the user
     *
     * :return (bool): whether the length of the password is 6 or over
     */
    return password.length >= 6;
  }
}
