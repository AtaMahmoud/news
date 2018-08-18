import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider {
  Database db;
  final String TABLE_NAME = 'Items';

  init() async {
    String path = await getDbPath();

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newsDb, int version) {
        newsDb.execute("""
          CREATE TABLE  $TABLE_NAME
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
       """);
      },
    );
  }

  Future<String> getDbPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return join(directory.path, "items.db");
  }

  fetchItem(int id) async {
    final maps = await db.query(
      TABLE_NAME,
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if(maps.length>0){
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  addItem(ItemModel item){
    return db.insert(TABLE_NAME, item.toMap());
  }
}
