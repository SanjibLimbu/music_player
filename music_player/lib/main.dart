import 'package:flutter/material.dart';
import 'package:music_player/screen/home_screen.dart';

void main() {
  runApp(const MusicApp());
}



class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),

      initialRoute: 'home_screen',
      routes: {
         'home_screen': (context) => const HomeScreen(),
      },

      
    );
  }
}