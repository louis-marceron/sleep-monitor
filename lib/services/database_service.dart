import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/sleep_model.dart';

class SleepDatabase {
  static final SleepDatabase _singleton = SleepDatabase._internal();

  Database? _database;

  factory SleepDatabase() {
    return _singleton;
  }

  SleepDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'sleep_db.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return db.execute(
          'CREATE TABLE sleep(start TEXT PRIMARY KEY, start TEXT)',
        );
      },
    );
  }

  Future<List<Sleep>> getAllSleeps() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('sleep');

    return List.generate(maps.length, (i) {
      return Sleep(maps[i]['start'], maps[i]['end']);
    });
  }

  Future<void> insertSleep(Sleep sleep) async {
    final db = await database;

    await db.insert(
      'sleep',
      sleep.toMap(),
    );
  }
}
