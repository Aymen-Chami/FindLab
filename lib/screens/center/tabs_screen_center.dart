// lib/screens/center/tabs_screen_center.dart
import 'package:findlab/screens/center/center_appointment_screen.dart';

import 'package:findlab/screens/center/center_home_screen.dart';
import 'package:findlab/screens/center/center_profile_screen.dart';
import 'package:flutter/material.dart';

class TabsScreenCenter extends StatefulWidget {
  const TabsScreenCenter({super.key});

  @override
  State<TabsScreenCenter> createState() => _TabsScreenCenterState();
}

class _TabsScreenCenterState extends State<TabsScreenCenter> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _navigators[_selectedIndex].currentState?.popUntil(
      (route) => route.isFirst,
    );
  }

  final List<GlobalKey<NavigatorState>> _navigators = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // Initialize _screens here to access _onItemTapped
    _screens = [
      CenterHomeScreen(onTabChange: _onItemTapped),
      CenterAppointmentsScreen(onTabChange: _onItemTapped),
      CenterProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children:
            _navigators.map((navigatorKey) {
              final index = _navigators.indexOf(navigatorKey);
              return Navigator(
                key: navigatorKey,
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => _screens[index],
                    settings: settings,
                  );
                },
              );
            }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 27,
        unselectedItemColor: const Color.fromARGB(255, 67, 118, 199),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 228, 79, 81),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 31),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Rendez-vous',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
