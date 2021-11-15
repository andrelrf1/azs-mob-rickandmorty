import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:rick_and_morty_app/models/episode.dart';

class SQLite {
  late Database _database;
  Map<String, dynamic> _queries = {
    'create':
        'CREATE TABLE episodes(id INTEGER PRIMARY KEY NOT NULL, name TEXT, episode VARCHAR(6), airDate VARCHAR(32), watched INTEGER, liked INTEGER);',
    'getAll': 'SELECT * FROM episodes;',
    'getLiked': 'SELECT * FROM episodes WHERE liked = ?;',
    'getWatched': 'SELECT * FROM episodes WHERE watched = ? AND id = ?;',
  };

  Future<void> connect() async {
    String path = await getDatabasesPath();
    String dataBasePath = join(path, 'app_data.db');
    _database = await openDatabase(
      dataBasePath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(_queries['create']);
      },
    );
  }

  Future<void> insertEpisode({required Episode episode}) async {
    await _database.insert(
      'episodes',
      episode.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Episode>> getEpisodes(String type, {int? id}) async {
    List<Map<String, dynamic>> episodes;
    if (type == 'getWatched') {
      episodes = await _database.rawQuery(_queries['getWatched'], [1, id]);
    } else if (type == 'liked') {
      episodes = await _database.rawQuery(_queries['getLiked'], [1]);
    } else {
      episodes = await _database.rawQuery(_queries['getAll']);
    }
    return List.generate(
      episodes.length,
      (index) => Episode(
        id: episodes[index]['id'],
        name: episodes[index]['name'],
        episode: episodes[index]['episode'],
        airDate: episodes[index]['airDate'],
        watched: episodes[index]['watched'] == 1 ? true : false,
        liked: episodes[index]['liked'] == 1 ? true : false,
      ),
    );
  }

  Future<void> updateEpisode(Episode episode) async {
    await _database.update(
      'episodes',
      episode.toMap(),
      where: 'id = ?',
      whereArgs: [episode.id],
    );
  }

  Future<void> deleteEpisode(Episode episode) async {
    await _database.delete(
      'episodes',
      where: 'id = ?',
      whereArgs: [episode.id],
    );
  }

  Future<void> disconnect() async {
    await _database.close();
  }
}
