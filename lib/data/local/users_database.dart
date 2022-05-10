import 'package:majootestcase/models/auth/user.dart';
import 'package:majootestcase/utils/app_strings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UsersDatabase {
  static final UsersDatabase instance = UsersDatabase._init();

  static Database? _database;

  UsersDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final userNameType = 'TEXT NOT NULL';
    final emailType = 'TEXT NOT NULL';
    final passwordType = 'TEXT NOT NULL';

    await db.execute(
        "CREATE TABLE $tableUsers(${NoteFields.id} $idType, ${NoteFields.userName} $userNameType, ${NoteFields.email} $emailType, ${NoteFields.password} $passwordType)");
  }

  Future<User> create(User user) async {
    try {
      final db = await instance.database;

      final id = await db.insert(tableUsers, user.toJson());
      return user.copy(id: id);
    } catch (e) {
      throw Exception(AppStrings.gagal_registrasi);
    }
  }

  Future<User?> login(String email) async {
    try {
      final db = await instance.database;

      final maps = await db.query(
        tableUsers,
        columns: NoteFields.values,
        where: '${NoteFields.email} = ?',
        whereArgs: [email],
      );

      if (maps.length > 0) {
        return User.fromJson(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(AppStrings.login_gagal);
    }
  }

  Future<User?> getUser(String email, String? username) async {
    try {
      final db = await instance.database;

      final maps = await db.query(
        tableUsers,
        columns: NoteFields.values,
        where: '${NoteFields.email} = ? OR ${NoteFields.userName} = ?',
        whereArgs: [email, username],
      );

      if (maps.length > 0) {
        return User.fromJson(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(AppStrings.login_gagal);
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
