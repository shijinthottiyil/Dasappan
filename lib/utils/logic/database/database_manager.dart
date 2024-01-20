import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/home/model/playlist_model.dart';
import 'package:music_stream/utils/logic/networking/networking.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  //Favorite
  static late Database _favoriteDb;
  static const _favoriteDbName = 'favorite.db';
  static const _favoriteDbTableName = 'FavoriteTable';
  static const _favoriteDbVersion = 1;

  // //Column Names
  static const _favoriteColumnId = 'videoId';
  static const _favoriteColumnTitle = 'videoTitle';
  static const _favoriteColumnThumbnail = 'videoThumbnail';
//INSERTION
  static Future<void> addToFavorite(PlaylistModel playlistModel) async {
    // favoriteDbIds.add(playlistModel.videoId!);
    await _favoriteDb.rawInsert(
      'INSERT OR REPLACE INTO $_favoriteDbTableName(id,$_favoriteColumnId,$_favoriteColumnTitle,$_favoriteColumnThumbnail)VALUES(?,?,?,?)',
      [
        playlistModel.videoId,
        playlistModel.videoId,
        playlistModel.title,
        playlistModel.thumbnail?.last.url,
      ],
    );
    // readFavoriteIds();
    // favoriteDbIds.add(playlistModel.videoId!);
  }

//DELETION
  static Future deleteFromFavorite({required String id}) async {
    // favoriteDbIds.remove(id);
    await _favoriteDb.delete(_favoriteDbTableName,
        where: '$_favoriteColumnId=?', whereArgs: [id]);

    // readFavoriteIds();
  }

//READ
  static Future<List<Map<String, Object?>>> readFavoriteIds() async {
    /*final queryResult = await _favoriteDb
        .query(_favoriteDbTableName, columns: [_favoriteColumnId]);*/
    // for (var row in queryResult) {
    //   // favoriteDbIds.add(row[_favoriteColumnId] as String);
    //   logger.i(row[_favoriteColumnId], error: 'Data in Favorite Database');
    // }
    final queryResult = await _favoriteDb.query(_favoriteDbTableName,
        orderBy: '$_favoriteColumnTitle ASC');
    return queryResult;

    // logger.i(favoriteDbIds, error: 'favoriteDbIds values');
  }

  //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  ///Methods to Initialize the Any Database we are going to use in this application.
  static Future<void> initializeDatabase() async {
    // Get a location using getDatabasesPath
    String favoriteDatabasesPath = await getDatabasesPath();
    String favoritePath = join(favoriteDatabasesPath, _favoriteDbName);
    _favoriteDb = await openDatabase(favoritePath, version: _favoriteDbVersion,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $_favoriteDbTableName (id TEXT PRIMARY KEY, $_favoriteColumnId TEXT, $_favoriteColumnTitle TEXT, $_favoriteColumnThumbnail TEXT)');
    });
  }
  //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
}
