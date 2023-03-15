import 'package:flutter/material.dart';

import 'package:music_player/constant/color.dart';
import 'package:music_player/constant/style.dart';

import 'package:music_player/screen/search_widget.dart';
import 'package:music_player/screen/songs_list_widget.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Hi There',
            style: titleLarge,
          ),
          Text(
            'What you want hear today?',
            style: textBodyDim,
          ),
          SizedBox(
            height: 15,
          ),
          SearchField(),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 5,
            ),
            child: Text(
              "Musics",
              style: labelMedium,
            ),
          ),
          SongsList()
        ],
      ),
    ));
  }
}
