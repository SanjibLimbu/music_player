import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/model/songs.dart';


import 'package:provider/provider.dart';
import 'package:music_player/screen/welcome_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('music_box');

  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SongsModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        initialRoute: 'welcome_screen',
        routes: {
          'welcome_screen': (context) =>const WelcomeScreen(),
        },
      ),
    );
  }
}
