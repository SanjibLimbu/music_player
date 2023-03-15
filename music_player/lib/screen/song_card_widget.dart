import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/constant/color.dart';
import 'package:music_player/constant/style.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    required this.songData,
    required this.songsData,
    super.key,
  });

  final dynamic songData;
  final dynamic songsData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'song_detail_page');
      },
      child: Padding(
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
            leading:
                QueryArtworkWidget(id: songData.id, type: ArtworkType.AUDIO)
                        .nullArtworkWidget ??
                    const Icon(
                      Icons.music_note,
                      size: 40,
                    ),
            
            //song title
            title: Text(songData.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: titleSmall),

                //artist name
            subtitle: Text(
              songData.artist ??= 'Unknown',
              style: textBodyDim,
            ),

            //play pause button
            trailing: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: textPrimary,
                shape: const CircleBorder(),
              ),
              onPressed: () {
                String? uri = songData.uri;

                songsData.player.setAudioSource(
                  AudioSource.uri(
                    Uri.parse(uri!),
                  ),
                );

                if (songsData.isPlayingVar &&
                    songData.id == songsData.songIDVar) {
                  songsData.player.pause();
                  songsData.changeBoolIsPlaying();
                } else {
                  //if other song is played without pausing playing song
                  if (songsData.isPlayingVar &&
                      songData.id != songsData.songIDVar) {
                    songsData.player.pause();
                    songsData.changeBoolIsPlaying();
                  }

                  songsData.player.play();
                  songsData.changeIsPlaying(songData.id);
                }
              },

              //id and uri is used to solve icon changing on all list item, for more see in songs.dart

              child: Icon(
                  songsData.isPlayingVar && songData.id == songsData.songIDVar
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                      color: bgColor,),
            ),
          ),
        ),
      ),
    );
  }
}
