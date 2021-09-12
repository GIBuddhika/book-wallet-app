import 'package:flutter_application_1/model/validation.dart';

class FormValidation {
  validate(input, rules) {
    bool isValid = true;
    String errMessage = '';
    for (var rule in rules) {
      switch (rule) {
        case 'email':
          if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
              .hasMatch(input)) {
            isValid = false;
            errMessage = "Invalid email";
          }
          break;
        case 'required':
          if (input == null || input.isEmpty) {
            isValid = false;
            errMessage = "This field is required";
          }
          break;
        default:
      }
    }

    return validationDataToJson(ValidationData(
      isValid: isValid,
      errMessage: errMessage,
    ));
  }
}
