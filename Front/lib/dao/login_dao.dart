import 'package:flutter/material.dart';
//import 'package:mobile/app/database/open_database.dart';
//import 'package:mobile/app/models/login.dart';
import 'package:sqflite/sqflite.dart';


import '../model/login.dart';
import 'open_database.dart';


class LoginDao {
  login(Login login) async {
    final Database db = await getDatabase();
    // final tables =
    //     await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    // print(tables);

    final tokens = await db.rawQuery("SELECT access_token FROM SESSION");
    final Map<String, dynamic> data = {'access_token': login.token};

    if (tokens.isEmpty || tokens.first['access_token'] == null) {
      await db.insert('SESSION', data,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      await db.update('SESSION', data);
    }

    final updatedTokens = await db.rawQuery("SELECT access_token FROM SESSION");

    if (updatedTokens.isEmpty || updatedTokens.first['access_token'] == null) {
      return false;
    }

    return true;
  }

  Future<String> getToken() async {
    final Database db = await getDatabase();
    // final tables =
    //     await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    // print(tables);

    final List<Map<String, dynamic>> maps = await db.query('SESSION');
    // final updatedTokens = await db.rawQuery("SELECT access_token FROM SESSION");
    // print(updatedTokens);

    if (maps.isNotEmpty) {
      final String token = maps.first['access_token'];

      return token;
    }

    return '';
  }

  Future<void> logout(context) async {
    final Database db = await getDatabase();
    await db.delete('SESSION');
    Navigator.of(context).pushReplacementNamed('/');


  }
}
