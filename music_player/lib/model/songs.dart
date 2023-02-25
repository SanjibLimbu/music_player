import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:on_audio_query/on_audio_query.dart';

class SongsModel extends ChangeNotifier {
  //use hive to save state

  final musicBox = Hive.box('music_box');
  final OnAudioQuery _audioQuery = OnAudioQuery();

  List foundSongs = [];
  List allSongs = [];

  late bool isPlayingVar;
  late num songIDVar;
  late String songURI;

  //initialize
  void isPlayingAndSondID() {
    isPlayingVar = musicBox.get('isPlaying') ?? false;
    songIDVar = musicBox.get('songID') ?? 0.1;
    songURI = musicBox.get('songURI') ?? 'URI';
  }

//after listening to stream, call after music finished
  void changeBoolIsPlaying() {
    final isPlaying = musicBox.get('isPlaying');
    musicBox.put('isPlaying', !isPlaying);
    isPlayingVar = musicBox.get('isPlaying');
    notifyListeners();
  }

  //get permission
  void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
    }
  }

//get songs
  getSongs() async {
    List<SongModel> externalSongs = await _audioQuery.querySongs(
      uriType: UriType.EXTERNAL,
    );
    List<SongModel> internalSongs = await _audioQuery.querySongs(
      uriType: UriType.INTERNAL,
    );

    List<SongModel> songsFromInternalAndExternal =
        internalSongs + externalSongs;
    List<SongModel> songs = songsFromInternalAndExternal
        .where((song) => song.isMusic == true)
        .toList();

    allSongs = songs;
    foundSongs = songs;
    notifyListeners();

    return foundSongs;
  }

//songID is used to solve problem to changing icon on list
  void changeIsPlaying(num id, String uri) {
    final isPlaying = musicBox.get('isPlaying') ?? false;
    musicBox.put('isPlaying', !isPlaying);
    musicBox.put('songID', id);
    musicBox.put('songURI', uri);
    isPlayingVar = musicBox.get('isPlaying');
    songIDVar = musicBox.get('songID');
    songURI = musicBox.get('songURI');

    notifyListeners();
  }

  // filter function
  void runSongsFilter(String value) async {
    if (value.isEmpty) {
      foundSongs = allSongs;
    } else {
      foundSongs = allSongs
          .where(
            (song) => song.title.toLowerCase().startsWith(
                  value.toLowerCase(),
                ),
          )
          .toList();
    }

    notifyListeners();
  }
}
