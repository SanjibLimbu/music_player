import 'package:flutter/material.dart';
import 'package:music_player/constant/color.dart';
import 'package:music_player/constant/style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
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
              padding: const EdgeInsets.only(top: 20,bottom: 5),
              child: Text(
                "Musics",
                style:
                    textStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            
            Flexible(
              child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return Container(
                      child: ListTile(
                        leading: Icon(Icons.music_note),
                        title: Text('Music'),
                        subtitle: Text('Singer'),
                        trailing: Icon(Icons.play_arrow),
                      ),
                    );
                  }),
            )
          ],
        ),
      )),
    );
  }
}
