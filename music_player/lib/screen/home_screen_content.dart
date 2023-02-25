import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/constant/color.dart';
import 'package:music_player/constant/style.dart';
import 'package:music_player/model/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({
    super.key,
  });

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    _player.playerStateStream.listen(
      (audioState) {
        if (audioState.processingState == ProcessingState.completed) {
          Provider.of<SongsModel>(context, listen: false).changeBoolIsPlaying();
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _player.processingStateStream;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi There',
            style:
                textStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text(
            'What you want hear today?',
            style: textStyle.copyWith(
                fontSize: 14,
                color: textSecondary,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 45,
            child: TextField(
              onChanged: (value) {
                Provider.of<SongsModel>(context, listen: false)
                    .runSongsFilter(value);
              },
              cursorColor: textSecondary,
              style: textStyle.copyWith(
                color: textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: textSecondary,
                ),
                filled: true,
                fillColor: bgColorSecondary,
                hintText: 'Search the music',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      5,
                    ),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              "Musics",
              style: textStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Flexible(
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
                                  color: textSecondary,
                                  fontWeight: FontWeight.w400),
                            ),
                            trailing: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: textPrimary,
                                shape: const CircleBorder(),
                              ),
                              onPressed: () {
                                String? uri = songsdata.foundSongs[index].uri;

                                _player.setAudioSource(
                                  AudioSource.uri(
                                    Uri.parse(uri!),
                                  ),
                                );

                                if (songsdata.isPlayingVar) {
                                  _player.pause();
                                  songsdata.changeIsPlaying(
                                    songsdata.foundSongs[index].id,
                                    uri,
                                  );
                                } else {
                                  _player.play();

                                  songsdata.changeIsPlaying(
                                    songsdata.foundSongs[index].id,
                                    uri,
                                  );
                                }
                              },

                              //id and uri is used to solve icon changing on all list item, for more see in songs.dart

                              child: Icon(songsdata.foundSongs[index].uri==songsdata.songURI
                                           &&
                                      songsdata.isPlayingVar &&
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
          )
        ],
      ),
    ));
  }
}
