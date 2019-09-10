import 'dart:async';

import 'package:carros_app/favoritos/favoritos.dart';
import 'package:carros_app/utils/db-helper.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object
class FavoritoDao {

  Future<Database> get db => DatabaseHelper.getInstance().db;

  Future<int> save(Favoritos favorito) async {
    var dbClient = await db;
    var id = await dbClient.insert("favorito", favorito.toMap(),
        //da update nos registos ja existentes evitando conflitos
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('id: $id');
    return id;
  }

  Future<List<Favoritos>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from favorito');

    final carros = list.map<Favoritos>((json) => Favoritos.fromMap(json)).toList();

    return carros;
  }

  Future<List<Favoritos>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from favorito where tipo =? ',[tipo]);

    final carros = list.map<Favoritos>((json) => Favoritos.fromMap(json)).toList();

    return carros;
  }

  Future<Favoritos> findById(int id) async {
    var dbClient = await db;
    final list =
    await dbClient.rawQuery('select * from favorito where id = ?', [id]);

    if (list.length > 0) {
      return new Favoritos.fromMap(list.first);
    }

    return null;
  }

  Future<bool> exists(int id) async {
    Favoritos c = await findById(id);
    var exists = c != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from favorito');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from favorito where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from favorito');
  }
}
