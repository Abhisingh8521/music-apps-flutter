// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_songs.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistSongsModelAdapter extends TypeAdapter<PlaylistSongsModel> {
  @override
  final int typeId = 1;

  @override
  PlaylistSongsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistSongsModel(
      songId: fields[0] as String?,
      fileName: fields[1] as String?,
      playlistId: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PlaylistSongsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.songId)
      ..writeByte(1)
      ..write(obj.fileName)
      ..writeByte(2)
      ..write(obj.playlistId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistSongsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
