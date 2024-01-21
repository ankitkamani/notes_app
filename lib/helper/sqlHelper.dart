import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE note(
        id TEXT,
        title TEXT,
        description TEXT
        )
      """);
  }

  static Future<Database> db() async {
    return openDatabase(
      'notesApp',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Read a single note by id
  static Future<List<Map<String, Object?>>> getNote(int id) async {
    final db = await SQLHelper.db();
    return  await  db.query('note', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Create new note
  static Future<int> createNote(
      String id, String title, String descrption) async {
    final db = await SQLHelper.db();

    final data = {'id': id, 'title': title, 'description': descrption};
    return await db.insert('note', data);
  }

  // Read all note
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('note', orderBy: "id");
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("note", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an note: $err");
    }
  }
}
