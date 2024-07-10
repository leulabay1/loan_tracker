String? amountValidator(String? input) {
  if (input == null) {
    return "Input is required";
  }

  if (num.tryParse(input) == null) {
    return "Input must be a valid number";
  }

  if (num.tryParse(input)! <= 0) {
    return "Input must be a positive number";
  }
}

String? textValidator(String? input) {
  if (input == null) {
    return "Input is required";
  }

  if (input.isEmpty) {
    return "Input can't be empty";
  }

  if (input.length < 4) {
    return "Input can't be less than 4 characters";
  }
}

String? passwordValidator(String? input) {
  if (input == null) {
    return "Input is required";
  }

  if (input.isEmpty) {
    return "Password can't be empty";
  }

  if (input.length < 4) {
    return "Password can't be less than 4 characters";
  }
}
