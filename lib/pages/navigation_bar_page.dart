import 'package:flutter/material.dart';
import 'package:my_movies/pages/favorite_movies_page.dart';
import 'package:my_movies/pages/movie_db_page.dart';
import 'package:my_movies/pages/my_movies_page.dart';
import 'package:my_movies/pages/profile_page.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MyMoviesPage(),
    MovieDbPage(),
    FavoriteMoviesPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Películas"),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: "Mis Películas"),
          BottomNavigationBarItem(
              icon: Icon(Icons.api), label: "MovieDB"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favoritas"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Mi Pérfil"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped
      ),
    );
  }
}
