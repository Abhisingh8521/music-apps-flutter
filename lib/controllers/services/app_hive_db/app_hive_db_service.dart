import 'package:hive_flutter/hive_flutter.dart';

import '../../../models/favorite_videos/favorite_video_model.dart';
import '../../../models/playlist/playlist_model.dart';
import '../../../models/playlist/playlist_songs.dart';

class HiveStorage {
  static Box<PlaylistModel>? _playlistBox;
  static Box<PlaylistSongsModel>? _playlistSongBox;
  static Box<FavoriteVideoModel>? _favoriteVideoBox;

  static Future get initialize async {
    await Hive.initFlutter();
    Hive.registerAdapter<PlaylistModel>(PlaylistModelAdapter());
    Hive.registerAdapter<PlaylistSongsModel>(PlaylistSongsModelAdapter());
    Hive.registerAdapter<FavoriteVideoModel>(FavoriteVideoModelAdapter());
    _playlistBox = await Hive.openBox<PlaylistModel>(
      'playlists',
    );
    _playlistSongBox = await Hive.openBox<PlaylistSongsModel>(
      'playlistSongs',
    );
    _favoriteVideoBox = await Hive.openBox('favoriteVideos');
  }

  static Future addNewPlaylist(PlaylistModel playlistModel) async {
    if (_playlistBox == null) await initialize;
    await _playlistBox?.put(playlistModel.playlistId, playlistModel);
  }

  static updatePlaylist(PlaylistModel playlistModel) async {
    if (_playlistBox == null) await initialize;
    await _playlistBox?.put(playlistModel.playlistId, playlistModel);
  }

  static deletePlaylist(PlaylistModel playlistModel) async {
    if (_playlistBox == null) await initialize;
    await _playlistBox?.delete(playlistModel.playlistId);
  }

  static deleteAllPlaylists() async {
    if (_playlistBox == null) await initialize;
    await _playlistBox?.deleteAll(_playlistBox!.keys);
  }

  static Future<List<PlaylistModel>?> getAllPlayLists() async {
    if (_playlistBox == null) await initialize;
    var data = _playlistBox?.values.toList();
    return data;
  }

  static getPlaylistAsStream() async {
    if (_playlistBox == null) await initialize;
    var data = _playlistBox?.watch();
    data?.listen((BoxEvent event) {
      var data = event.value;
      print("$event");
    });
  }

  static addNewSongToPlaylist(PlaylistSongsModel songsModel) async {
    if (_playlistSongBox == null) await initialize;
    await _playlistSongBox?.put(songsModel.songId, songsModel);
  }

  static removeSongFromPlaylist(id) async {
    if (_playlistSongBox == null) await initialize;
    await _playlistSongBox?.delete(id);
  }

  static Future<List<PlaylistSongsModel>?> getAllPlaylistSongs(
      PlaylistModel playlistModel) async {
    if (_playlistSongBox == null) await initialize;
    return _playlistSongBox?.values
        .toList()
        .where((e) => e.playlistId == playlistModel.playlistId)
        .toList();
  }

  static addToFavoriteVideo(FavoriteVideoModel favoriteVideoModel) async {
    if (_favoriteVideoBox == null) await initialize;
    await _favoriteVideoBox?.put(favoriteVideoModel.favoriteId,favoriteVideoModel);
  }

  static removeFromFavoriteVideo(String id) async {
    if (_favoriteVideoBox == null) await initialize;
    var data = _favoriteVideoBox?.values
        .toList()
        .where((element) => element.songId == id)
        .toList();
    if (data?.isNotEmpty == true) {
      await _favoriteVideoBox?.delete(data?.first.favoriteId ?? "");

    }
  }

  static Future<List<FavoriteVideoModel>?> getAllFavoriteVideos() async {
    if (_favoriteVideoBox == null) await initialize;
    var data = _favoriteVideoBox?.values.toList();
    return data;
  }

  static bool? checkFavStatus(songId) {
    if (_favoriteVideoBox == null) {
      initialize.then((value) {
        var data = _favoriteVideoBox?.values
            .toList()
            .where((element) => element.songId == songId)
            .isNotEmpty;
        return data;
      });
    } else {
      var data = _favoriteVideoBox?.values
          .toList()
          .where((element) => element.songId == songId)
          .isNotEmpty;
      return data;
    }
  }
}
