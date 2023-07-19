import 'package:euro_park_app/model/Vaga.dart';
import 'package:sqflite/sqflite.dart';

import 'open_database.dart';

class VagaDAO{

  adicionar(Vaga v) async {
    final Database db = await getDatabase();
    db.insert('VAGA', v.toMap());
  }
  Future<List<Vaga>> getVagas() async{
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('VAGA');

    return List.generate(maps.length, (i) {
      return Vaga(
        id: maps[i]['id'],
        vaga: maps[i]['vaga'],
        valor: maps[i]['valor'],
      );

    });
  }

  excluir(int id) async {
    final Database db = await getDatabase();
    db.delete('VAGA', where: 'id = ?', whereArgs: [id]);
  }
}