import 'dart:convert';

ValidationData validationDataFromJson(String str) =>
    ValidationData.fromJson(json.decode(str));

String validationDataToJson(ValidationData data) => json.encode(data.toJson());

class ValidationData {
  ValidationData({
    required this.isValid,
    required this.errMessage,
  });

  bool isValid;
  String errMessage;

  factory ValidationData.fromJson(Map<String, dynamic> json) => ValidationData(
        isValid: json["is_valid"],
        errMessage: json["err_message"],
      );

  Map<String, dynamic> toJson() => {
        "is_valid": isValid,
        "err_message": errMessage,
      };
}
