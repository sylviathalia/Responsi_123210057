import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/job_model.dart';

class BookmarkService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'bookmark.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE bookmarks(id INTEGER PRIMARY KEY, jobTitle TEXT, companyName TEXT, jobDescription TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> addBookmark(Jobs job) async {
    final db = await database;
    await db.insert(
      'bookmarks',
      {
        'id': job.id,
        'jobTitle': job.jobTitle,
        'companyName': job.companyName,
        'jobDescription': job.jobDescription,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Jobs>> getBookmarks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bookmarks');
    return List.generate(maps.length, (i) {
      return Jobs(
        id: maps[i]['id'],
        jobTitle: maps[i]['jobTitle'],
        companyName: maps[i]['companyName'],
        jobDescription: maps[i]['jobDescription'],
      );
    });
  }

  static Future<void> removeBookmark(int id) async {
    final db = await database;
    await db.delete(
      'bookmarks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
