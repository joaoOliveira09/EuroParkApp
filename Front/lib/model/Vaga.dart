import 'dart:convert';

class Vaga {
  int? id;
  int vaga;
  double valor;

  Vaga({this.id, required this.vaga, required this.valor});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vaga': vaga,
      'valor': valor,
    };
  }

  String toJson() {
    final map = toMap();
    return jsonEncode(map);
  }

  static Vaga fromMap(Map<String, dynamic> map) {
    return Vaga(
      id: map['id'],
      vaga: map['vaga'],
      valor: map['valor'],
    );
  }

  static Vaga fromJson(String json) {
    final map = jsonDecode(json);
    return fromMap(map);
  }
}
