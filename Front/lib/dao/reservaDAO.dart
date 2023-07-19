import 'package:euro_park_app/model/Reservas.dart';

import 'package:sqflite/sqflite.dart';

import 'open_database.dart';

class ReservaDAO {
  adicionar(Reservas r) async {
    final Database db = await getDatabase();
    db.insert('RESERVA', r.toMap());
  }

  Future<List<Reservas>> getReservas() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('RESERVA');

    return List.generate(maps.length, (i) {
      return Reservas(
        id: maps[i]['id'],
        vaga: maps[i]['vaga'],
        periodo: maps[i]['periodo'],
      );
    });
  }
  excluir(int id) async {
    final Database db = await getDatabase();
    db.delete('RESERVA', where: 'id = ?', whereArgs: [id]);
  }
}
