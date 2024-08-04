
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../services/app_storage_services/songs/app_music_services.dart';

class MusicController extends GetxController {
  RxList<SongModel> musicList = <SongModel>[].obs;
  RxList<AlbumModel> albumList = <AlbumModel>[].obs;
  Rx<AudioPlayer> audioPlayer = AudioPlayer().obs;
  RxBool isPlaying = false.obs;
  RxInt selectedAlbumIndex = 0.obs;
  RxInt selectedMusicIndex = 0.obs;
  SongModel get selectSong => musicList[selectedMusicIndex.value];
  @override
  void onInit() {
    getAllData();
    super.onInit();
  }

  void getAllData() async {
    musicList.value = await AppMusicService.getAllMusic();
    albumList.value = await AppMusicService.getAllAlbums();
  }

  get initializeMusic async {
   // var img = await AppMusicService.getArtWork(id: musicList[selectedMusicIndex.value].id);
    audioPlayer.value.setAudioSource( AudioSource.file(
        musicList[selectedMusicIndex.value].data,
        tag: MediaItem(
            id: selectedMusicIndex.value.toString(),
            title: musicList[selectedMusicIndex.value].title,
            album: musicList[selectedMusicIndex.value].album,
          playable:true
        ),
    ),

    );

    audioPlayer.value.play();
    isPlaying.value = true;
  }

  get playPauseTap {
    if (audioPlayer.value.playing) {
      audioPlayer.value.pause();
      isPlaying.value = false;
    } else {
      audioPlayer.value.play();
      isPlaying.value = true;
    }
  }
}
