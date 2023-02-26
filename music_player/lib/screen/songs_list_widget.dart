import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/constant/color.dart';
import 'package:music_player/constant/style.dart';
import 'package:music_player/model/songs.dart';
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
        builder: (context, songsdata, child) {
          if (songsdata.foundSongs.isEmpty) {
            return const Center(
              child: Text("No Songs"),
            );
          } else {
            return ListView.builder(
              itemCount: songsdata.foundSongs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColorSecondary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: ListTile(
                      visualDensity: const VisualDensity(vertical: -4),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                      leading: QueryArtworkWidget(
                                  id: songsdata.foundSongs[index].id,
                                  type: ArtworkType.AUDIO)
                              .nullArtworkWidget ??
                          const Icon(
                            Icons.music_note,
                            size: 40,
                          ),
                      title: Text(
                        songsdata.foundSongs[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle.copyWith(
                            color: textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        songsdata.foundSongs[index].artist ??= 'Unknown',
                        style: textStyle.copyWith(
                            color: textSecondary, fontWeight: FontWeight.w400),
                      ),
                      trailing: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: textPrimary,
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          String? uri = songsdata.foundSongs[index].uri;

                          songsdata.player.setAudioSource(
                            AudioSource.uri(
                              Uri.parse(uri!),
                            ),
                          );

                          if (songsdata.isPlayingVar &&
                              songsdata.foundSongs[index].id ==
                                  songsdata.songIDVar) {
                            songsdata.player.pause();
                            songsdata.changeBoolIsPlaying();
                          } else {
                            //if other song is played without pausing playing song
                            if (songsdata.isPlayingVar &&
                                songsdata.foundSongs[index].id !=
                                    songsdata.songIDVar) {
                              songsdata.player.pause();
                              songsdata.changeBoolIsPlaying();
                            }

                            songsdata.player.play();
                            songsdata.changeIsPlaying(
                                songsdata.foundSongs[index].id);
                          }
                        },

                        //id and uri is used to solve icon changing on all list item, for more see in songs.dart

                        child: Icon(songsdata.isPlayingVar &&
                                songsdata.foundSongs[index].id ==
                                    songsdata.songIDVar
                            ? Icons.pause_sharp
                            : Icons.play_arrow_sharp),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
