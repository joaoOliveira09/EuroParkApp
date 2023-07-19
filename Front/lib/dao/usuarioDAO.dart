import 'package:sqflite/sqflite.dart';
import '../model/usuario.dart';
import 'open_database.dart';

class UsuarioDAO {
  Future<void> adicionar(Usuario u) async {
    final Database db = await getDatabase();
    await db.insert('USUARIO', u.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Usuario>> getUsuarios() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('USUARIO');
    return List.generate(maps.length, (i) {
      return Usuario(
        id: maps[i]['id'],
        login: maps[i]['login'],
        senha: maps[i]['senha'],
        saldo: maps[i]['saldo'],
      );
    });
  }

  Future<void> atualizar(Usuario u) async {
    final Database db = await getDatabase();
    await db.update(
      'USUARIO',
      u.toMap(),
      where: 'id = ?',
      whereArgs: [u.id],
    );
  }

  Future<void> deletarUsuario(int id) async {
    final Database db = await getDatabase();
    await db.delete(
      'USUARIO',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Usuario> getUsuarioById(int id) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'USUARIO',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return Usuario(
        id: maps[0]['id'],
        login: maps[0]['login'],
        senha: maps[0]['senha'],
        saldo: maps[0]['saldo'],
      );
    } else {
      throw Exception('Usuário não encontrado');
    }
  }
}
