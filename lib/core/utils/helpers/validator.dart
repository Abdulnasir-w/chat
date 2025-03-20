String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email address';
  }
  final emailRegex = RegExp(r'\S+@\S+\.\S+');
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validateNotEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field cannot be empty';
  }
  return null;
}
