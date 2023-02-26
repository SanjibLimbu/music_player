import 'package:flutter/material.dart';
import 'package:music_player/constant/color.dart';
import 'package:music_player/model/songs.dart';

import 'package:music_player/screen/home_screen_content.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Provider.of<SongsModel>(context, listen: false).requestStoragePermission();
    super.initState();
  }

  // @override
  // void dispose() {
  //   Provider.of<SongsModel>(context, listen: false)
  //       .player
  //       .processingStateStream;

  //   super.dispose();
  // }

  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreenContent(),
    const Text(
      'Index 1: Business',
    ),
    const Text(
      'Index 2: School',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bgColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: const Color.fromARGB(255, 103, 102, 102),
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
