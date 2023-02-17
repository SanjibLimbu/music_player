import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/constant/color.dart';
import 'package:music_player/constant/style.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreenContent extends StatelessWidget {
  HomeScreenContent({
    super.key,
  });

  final OnAudioQuery _audioQuery = OnAudioQuery();

  final AudioPlayer _player = AudioPlayer();

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
              onChanged: (value) {},
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
            child: FutureBuilder(
              future: _audioQuery.querySongs(
                  // sortType: null,
                  // uriType: UriType.INTERNAL,
                  orderType: OrderType.ASC_OR_SMALLER,
                  ignoreCase: true),
              builder: (context, item) {
                if (item.data == null) {
                  return const Center(
                    child: Text('No songs Found'),
                  );
                } else {
                  return ListView.builder(
                      itemCount: item.data!.length,
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
                                          id: item.data![index].id,
                                          type: ArtworkType.AUDIO)
                                      .nullArtworkWidget ??
                                  const Icon(
                                    Icons.music_note,
                                    size: 40,
                                  ),
                              title: Text(
                                item.data![index].title,
                                style: textStyle.copyWith(
                                    color: textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                item.data![index].artist ?? 'Unknown',
                                style: textStyle.copyWith(
                                    color: textSecondary,
                                    fontWeight: FontWeight.w400),
                              ),
                              trailing: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: textPrimary,
                                  shape: const CircleBorder(),
                                ),
                                onPressed: () async {
                                  String? uri = item.data![index].uri;

                                  await _player.setAudioSource(
                                    AudioSource.uri(
                                      Uri.parse(uri!),
                                    ),
                                  );
                                  await _player.play();
                                },
                                child: const Icon(
                                  Icons.play_arrow_sharp,
                                  color: bgColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}
