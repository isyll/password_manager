class SigninCredentials {
  String? username;
  String? password;

  SigninCredentials({
    this.username,
    this.password,
  });

  bool get isValid => username != null && password != null;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'username': username});
    result.addAll({'password': password});

    return result;
  }
}
