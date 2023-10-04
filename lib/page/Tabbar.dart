import 'package:flutter/material.dart';
import 'package:gaminfo/page/Favorite.dart';
import 'package:gaminfo/page/search.dart';

import 'home.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({super.key, required this.halamanke});
  final int halamanke;
  @override
  _TabbarState createState() => _TabbarState();

}

class _TabbarState extends State<Tabbar> {
  late PageController _pageController;
  int selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan ketika item bottom navigation dipilih.
  final List<Widget> _pages = [
    // Halaman Home
    home(),
    // Halaman Favorite
    Favorites(),


  ];

  @override
  void initState() {
    super.initState();
    int requestindex=widget.halamanke;
    print( "nilai awal selectedIndex $selectedIndex");
    switch(requestindex){
      case 0:selectedIndex=selectedIndex; break;
      case 1:selectedIndex= selectedIndex+ widget.halamanke;break;
      case 2:selectedIndex= selectedIndex+ widget.halamanke;break;
      case 3:selectedIndex= selectedIndex+ widget.halamanke;break;

    }
    print( "selectedIndex $selectedIndex");

    _pageController = PageController(initialPage: widget.halamanke);
  }
  void onButtonPressed(int index) {
    print(index);
    setState(() {
      selectedIndex = index;
      print("selected index :$selectedIndex");
      print("selected index 2:$selectedIndex");

    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages[selectedIndex], // Menampilkan halaman sesuai dengan indeks yang dipilih.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap:onButtonPressed,
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
