class SigninCredentials {
  String? email;
  String? password;

  SigninCredentials({
    this.email,
    this.password,
  });

  bool get isValid => email != null && password != null;

  Map<String, dynamic> toMap() {
    final result = <String, String?>{};

    result.addAll({'email': email});
    result.addAll({'password': password});

    return result;
  }
}
