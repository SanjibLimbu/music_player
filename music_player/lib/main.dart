import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/model/songs.dart';
import 'package:music_player/screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('music_box');
  Hive.box('music_box').clear();
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
        initialRoute: 'home_screen',
        routes: {
          'home_screen': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
