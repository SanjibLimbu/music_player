import 'package:flutter/material.dart';
import 'package:music_player/constant/color.dart';
import 'package:music_player/constant/style.dart';
import 'package:music_player/model/songs.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}