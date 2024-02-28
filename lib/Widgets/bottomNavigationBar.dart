import 'package:flutter/material.dart';

import '../Views/MainScreens/favorites_screen.dart';
import '../Views/MainScreens/home_screen.dart';
import '../Views/MainScreens/mytrips_screen.dart';
import '../Views/MainScreens/profile_screen.dart';
import '../core/app_colors/app_colors.dart';

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({super.key});

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  final List<Widget> _pages = [
    SizedBox(),
    FavoriteScreen(),
    MyTripsScreen(),
    ProfileScreen(),
  ];
  int  _currentIndex = 0 ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: AppColors.Blue,
        unselectedItemColor:AppColors.gray ,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flight_takeoff),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
