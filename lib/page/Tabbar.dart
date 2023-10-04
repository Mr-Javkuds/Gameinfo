import 'package:flutter/material.dart';
import 'package:gaminfo/page/Favorite.dart';
import 'package:gaminfo/page/search.dart';

import 'home.dart';

class Tabbar extends StatefulWidget {
  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  int _currentIndex = 0;

  // Daftar halaman yang akan ditampilkan ketika item bottom navigation dipilih.
  final List<Widget> _pages = [
    // Halaman Home
    home(),
    // Halaman Favorite
    Favorites(),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Menampilkan halaman sesuai dengan indeks yang dipilih.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index; // Mengganti halaman saat item dipilih.
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
