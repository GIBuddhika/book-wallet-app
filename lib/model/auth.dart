import 'dart:convert';

AuthData authDataFromJson(String str) => AuthData.fromJson(json.decode(str));

String authDataToJson(AuthData data) => json.encode(data.toJson());

class AuthData {
  AuthData({
    required this.apiToken,
  });

  String apiToken;

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
        apiToken: json["api_token"],
      );

  Map<String, dynamic> toJson() => {
        "api_token": apiToken,
      };
}
