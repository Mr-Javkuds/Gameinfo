import 'package:gaminfo/model/game_fav.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Fav_DB {
  static final Fav_DB instance = Fav_DB.init();
  static Database? _database;

  Fav_DB.init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('favorit.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NULL';

    await db.execute('''CREATE TABLE $tableFavorite (
    ${Favorite.id} $idType,
    ${Favorite.image} $textType,
    ${Favorite.name} $textType,
    ${Favorite.slug} $textType,
    ${Favorite.released} $textType,
    ${Favorite.rating} $textType,
    ${Favorite.idDetail} $textType
)''');


  }

  Future<FavoriteModel> create(FavoriteModel favTable) async {
    final db = await instance.database;
    final id = await db.insert(tableFavorite, favTable.toJson());
    return favTable.copy(id: id);
  }

  Future<bool> read(String? name) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFavorite,
      columns: Favorite.values,
      where: '${Favorite.name} = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<FavoriteModel>> readAll() async {
    final db = await instance.database;
    final result = await db.query(tableFavorite);
    return result.map((json) => FavoriteModel.fromJson(json)).toList();
  }

  delete(String? name) async {
    final db = await instance.database;
    try {
      await db.delete(
        tableFavorite,
        where: '${Favorite.name} = ?',
        whereArgs: [name],
      );
    } catch (e) {
      print(e);
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}