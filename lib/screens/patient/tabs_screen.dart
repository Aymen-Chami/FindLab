import 'package:findlab/screens/patient/appointments_screen.dart';
import 'package:findlab/screens/patient/home_screen.dart';
import 'package:findlab/screens/patient/profile_screen.dart';

import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AppointmentsScreen(),
    const ProfileScreen(),
  ];

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
