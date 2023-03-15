import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/constant/color.dart';
import 'package:music_player/constant/style.dart';
import 'package:music_player/model/songs.dart';
import 'package:music_player/screen/song_card_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SongsList extends StatefulWidget {
  const SongsList({
    super.key,
  });

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  @override
  void initState() {
    Provider.of<SongsModel>(context, listen: false).isPlayingAndSondID();
    Provider.of<SongsModel>(context, listen: false).getSongs();
    //listening if songs finished
    Provider.of<SongsModel>(context, listen: false)
        .player
        .playerStateStream
        .listen(
      (audioState) {
        if (audioState.processingState == ProcessingState.completed) {
          Provider.of<SongsModel>(context, listen: false).changeBoolIsPlaying();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Consumer<SongsModel>(
        builder: (context, songsData, child) {
          if (songsData.foundSongs.isEmpty) {
            return const Center(
              child: Text("No Songs"),
            );
          } else {
            return ListView.builder(
              itemCount: songsData.foundSongs.length,
              itemBuilder: (context, index) {
                return SongCard(
                    songData: songsData.foundSongs[index],
                    songsData: songsData);
              },
            );
          }
        },
      ),
    );
  }
}


