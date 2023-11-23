import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Animal.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'animal_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE animals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''');
  }

  Future<int> insertAnimal(Animal animal) async {
    Database db = await instance.database;
    return await db.insert('animals', animal.toMap());
  }

  Future<List<Animal>> getAllAnimals() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('animals');
    return List.generate(maps.length, (index) {
      return Animal.fromMap(maps[index]);
    });
  }
}
