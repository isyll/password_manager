class SigninResponse {
  final String accessToken;
  final String refreshToken;

  SigninResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory SigninResponse.fromMap(Map<String, dynamic> map) {
    return SigninResponse(
      accessToken: map['access_token'] as String,
      refreshToken: map['refresh_token'] as String,
    );
  }
}
