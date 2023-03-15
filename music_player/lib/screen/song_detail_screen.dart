import 'package:flutter/material.dart';
import 'package:music_player/constant/color.dart';
import 'package:music_player/constant/style.dart';

class SongDetailPage extends StatelessWidget {
  const SongDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Now Playing',
          style: titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            icon: const Icon(
              Icons.favorite_outline_rounded,
              color: textPrimary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              child: FittedBox(
                child: Icon(
                  Icons.music_note,
                ),
              ),
            ),
            const Text(
              'Chained to the Rhythm',
              overflow: TextOverflow.ellipsis,
              style: titleSmall,
            ),
            const Text(
              'Katty Perry',
              style: textBodyDim,
            ),

            //progress bar

            const Spacer(),

            //button control
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                //shuffle button
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(padding: EdgeInsets.zero),
                  icon: const Icon(
                    Icons.shuffle_rounded,
                    color: textPrimary,
                    // size: 35,
                  ),
                ),
               
                //previous button
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(padding: EdgeInsets.zero),
                  icon: const Icon(
                    Icons.skip_previous_rounded,
                    color: textPrimary,
                    size: 35,
                  ),
                ),
             
                //play pause button
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(50, 50),
                    padding: EdgeInsets.zero,
                    backgroundColor: textPrimary,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    // String? uri = songData.uri;

                    // songsData.player.setAudioSource(
                    //   AudioSource.uri(
                    //     Uri.parse(uri!),
                    //   ),
                    // );

                    // if (songsData.isPlayingVar &&
                    //     songData.id == songsData.songIDVar) {
                    //   songsData.player.pause();
                    //   songsData.changeBoolIsPlaying();
                    // } else {
                    //   //if other song is played without pausing playing song
                    //   if (songsData.isPlayingVar &&
                    //       songData.id != songsData.songIDVar) {
                    //     songsData.player.pause();
                    //     songsData.changeBoolIsPlaying();
                    //   }

                    //   songsData.player.play();
                    //   songsData.changeIsPlaying(songData.id);
                    // }
                  },

                  //id and uri is used to solve icon changing on all list item, for more see in songs.dart

                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: bgColor,
                    size: 35,
                  ),
                ),
             
                //previous button
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(padding: EdgeInsets.zero),
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    color: textPrimary,
                    size: 35,
                  ),
                ),
              
                //shuffle button
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(padding: EdgeInsets.zero),
                  icon: const Icon(
                    Icons.loop_rounded,
                    color: textPrimary,
                    // size: 35,
                  ),
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
