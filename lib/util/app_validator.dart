class Appvalidator {
  String? emailValidator(value) {
    if (value.isEmpty || value == null) {
      return "Please enter your email address";
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value.isEmpty || value == null) {
      return "Please enter your password";
    }
    return null;
  }

  String? mobileNumberValidator(value) {
    if (value.isEmpty || value == null) {
      return "Please enter your mobile number";
    }
    return null;
  }

  String? categoryList(value) {
    if (value.isEmpty || value == null) {
      return "Please select your category";
    }
    return null;
  }

  String? formFill(value) {
    if (value.isEmpty || value == null) {
      return "Please fill the form";
    }
    return null;
  }
}
