

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-mail address is required.';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required.';
  }
  String pattern =
      r'^(?=.*?[0-9]).{6,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword)) {
    return '''
    Password must be at least 6 characters,
    include a number.
    ''';
  }

  return null;
}

String? validateFullName(String? formFullName) {
  if (formFullName == null || formFullName.isEmpty) {
    return 'Full Name is required.';
  }else if (formFullName.length < 4 || formFullName.length > 25){
    return 'Full Name must be between 4 and 25 characters.';
  }
  return null;
}

String? validatePhoneNumber(String? formPhoneNumber) {
  if (formPhoneNumber == null || formPhoneNumber.isEmpty) {
    return 'PhoneNumber is required.';
  } else if (formPhoneNumber.length != 11) {
    return 'PhoneNumber should be eleven digits.';
  }

  return null;
}

