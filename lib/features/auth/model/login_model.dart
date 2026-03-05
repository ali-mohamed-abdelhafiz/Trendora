class LoginModel {
  final String accessToken;
  final DateTime expiresAtUtc;
  final String refreshToken;

  LoginModel({
    required this.accessToken,
    required this.expiresAtUtc,
    required this.refreshToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json['accessToken'] ?? '',
      expiresAtUtc: DateTime.parse(json['expiresAtUtc']),
      refreshToken: json['refreshToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "accessToken": accessToken,
      "expiresAtUtc": expiresAtUtc.toIso8601String(),
      "refreshToken": refreshToken,
    };
  }
}
