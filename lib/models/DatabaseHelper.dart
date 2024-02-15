import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Task.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const dateType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE tasks (
  id $idType,
  title $textType,
  dueDate $dateType,
  completed $boolType
)
''');
  }

  Future<Task> createTask(Task task) async {
    final db = await instance.database;
    final id = await db.insert('tasks', task.toMap());
    return task.copyWith(id: id);
  }

  Future<List<Task>> getTasks() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        dueDate: DateTime.parse(maps[i]['dueDate']),
        completed: maps[i]['completed'] == 1,
      );
    });
  }

  Future<int> updateTask(Task task) async {
    final db = await instance.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Ajoutez d'autres méthodes pour lire, mettre à jour et supprimer des tâches...

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
