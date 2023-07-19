import 'dart:convert';

class Reservas {
  int? id;
  int vaga;
  String periodo;

  Reservas({this.id, required this.vaga, required this.periodo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vaga': vaga,
      'periodo': periodo,
    };
  }

  String toJson() {
    final map = toMap();
    return jsonEncode(map);
  }

  static Reservas fromMap(Map<String, dynamic> map) {
    return Reservas(
      id: map['id'],
      vaga: map['vaga'],
      periodo: map['periodo'],
    );
  }

  static Reservas fromJson(String json) {
    final map = jsonDecode(json);
    return fromMap(map);
  }
}
