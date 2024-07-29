class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email Field Cannot be Empty";
    }
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    if (emailRegex.hasMatch(value)) {
      return "Enter a Valid Email";
    }
    return null;
  }

  static String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return "Field cannot be Empty";
    }
    return null;
  }
}
