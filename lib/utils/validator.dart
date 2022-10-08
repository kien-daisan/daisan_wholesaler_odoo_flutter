class Validator {
  static bool isEmpty(String value) {
    return value.isEmpty;
  }

  static String? isEmailValid(String email) {
    var emailRegExp = RegExp("[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+");
    if (isEmpty(email)) {
      return "Email is required";
    } else if (!emailRegExp.hasMatch(email)) {
      return "Please enter a valid email";
    }
    return null;
  }
  static String? isNameValid(String email) {
    var emailRegExp = RegExp("[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+");
    if (isEmpty(email)) {
      return "Name is required";
    }
    return null;
  }

  static String? isValidPassword(String password) {
    if (isEmpty(password)) {
      return "Password is required";
    } else if (password.trim().length <= 5) {
      return "Password must have at least 6 characters and Leading or trailing spaces will be ignored.";
    }
    return null;
  }
}
