class Login {
  String? _username;
  String? _senha;
  String? _token;

  Login({String? username, String? senha, String? token})
      : _username = username,
        _senha = senha,
        _token = token;

  Map<String, dynamic> toMap() {
    return {'username': username, 'senha': senha, 'token': token};
  }

  factory Login.fromJsonToken(Map<String, dynamic> json) {
    return Login(token: json['token']);
  }

  String? get username => _username ?? null;
  String? get senha => _senha ?? null;
  String? get token => _token;

  set username(String? username) {
    _username = username;
  }

  set senha(String? senha) {
    _senha = senha;
  }
}
