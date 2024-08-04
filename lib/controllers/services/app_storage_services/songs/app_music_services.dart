import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_audio_query/on_audio_query.dart';
class AppMusicService{
  static  final OnAudioQuery _audioQuery = OnAudioQuery();
static Future<List<SongModel>> getAllMusic() async{
   var musicList = await _audioQuery.querySongs(sortType: SongSortType.DATE_ADDED,orderType: OrderType.DESC_OR_GREATER,);
     var data = musicList.where((element) => element.album != "Call Recordings").toList();
   return data;
  }
static Future<List<AlbumModel>> getAllAlbums() async{
  var albumList = await _audioQuery.queryAlbums(sortType: AlbumSortType.NUM_OF_SONGS,orderType: OrderType.DESC_OR_GREATER);

  return albumList;

}

static Future<Uint8List?> getArtWork({required int id,ArtworkType? type}){
 return _audioQuery.queryArtwork(id, type ?? ArtworkType.AUDIO);

}

}