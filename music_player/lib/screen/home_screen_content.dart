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
          const SearchField(),
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
          const SongsList()
        ],
      ),
    ));
  }
}
