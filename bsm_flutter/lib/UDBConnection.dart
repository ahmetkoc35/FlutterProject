import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabaseConnection {

  static final UserDatabaseConnection instance = UserDatabaseConnection._privateConstructor();
  static Database? _database;

  static final _databaseName = "userDatabase1";
  static final _databaseVersion = 1;
  static final tableName = "MyUsers";
  static final username = "username";
  static final password = "password";
  static final totalMile = "totalMile";

  UserDatabaseConnection._privateConstructor()
  {
    _initDatabase();
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        $username TEXT PRIMARY KEY NOT NULL,
        $password TEXT NOT NULL,
        $totalMile REAL DEFAULT 0
      )
    ''');
  }

  Future<void> insertUser(String username, String password) async {
    final db = await instance.database;
    await db.insert(tableName, {'username': username, 'password': password});
  }

  void fetchUsers() async {
    Database database = await openDatabase(_databaseName);
    List<Map<String, dynamic>> users = await database.query(tableName);
    if(users.isNotEmpty)
    {

      for(int i = 0; i < users.length; i++)
      {
        print("---------------------------");
        print(users[i]);
      }
    }
    else
    {
      print("---------------------------empty");
    }
  }

  Future<bool> loginUser(String username, String password) async {
    Database database = await openDatabase(_databaseName);
    List<Map<String, dynamic>> users = await database.query(
      tableName,
      where: 'username = ?',
      whereArgs: [username],
    );

    if (users.isNotEmpty) {
      Map<String, dynamic> user = users.first;
      String storedPassword = user['password'];

      if (password == storedPassword) {
        return true;
      }
    }
    return false;
  }
  Future<bool> searchUser(String username) async {
    Database database = await openDatabase(_databaseName);
    List<Map<String, dynamic>> users = await database.query(
      tableName,
      where: 'username = ?',
      whereArgs: [username],
    );

    if (users.isNotEmpty) {
      return false;
    }
    return true;
  }

  Future<void> insertRun(String username, double todaysMile) async {
    final db = await instance.database;

    List<Map<String, dynamic>> users = await db.query(tableName, where: 'username = ?', whereArgs: [username]);

    if (users.isNotEmpty) {
      Map<String, dynamic> user = users.first;
      double totalMile = user['totalMile'] as double;

      totalMile += todaysMile;

      await db.update(
        tableName,
        {'username': username, 'totalMile': totalMile},
        where: 'username = ?',
        whereArgs: [username],
      );
    }
  }

  Future<double?> getTotalMiles(String username) async {
    final db = await instance.database;
    List<Map<String, dynamic>> users = await db.query(tableName, where: 'username = ?', whereArgs: [username]);

    if (users.isNotEmpty) {
      Map<String, dynamic> user = users.first;
      double totalMiles = user['totalMile'];
      return totalMiles;
    }
    return null;
  }
}