import 'dart:convert';

class Usuario {
  int? id;
  String login;
  String senha;
  double saldo;

  Usuario({this.id, required this.login, required this.senha, required this.saldo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'senha': senha,
      'saldo': saldo,
    };
  }

  String toJson() {
    final map = toMap();
    return jsonEncode(map);
  }

  static Usuario fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      login: map['login'],
      senha: map['senha'],
      saldo: map['saldo'],
    );
  }

  static Usuario fromJson(String json) {
    final map = jsonDecode(json);
    return fromMap(map);
  }
}
