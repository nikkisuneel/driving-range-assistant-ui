import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    switch(index) {
      case 0:
        Navigator.pushNamed(context, "/select-image");
        break;
      case 1:
        Navigator.pushNamed(context, "/configure-pickers");
        break;
      case 2:
        Navigator.pushNamed(context, "/trends");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentRoute = ModalRoute.of(context).settings.name;

    if (currentRoute == '/fixed-image') {
      _selectedIndex = 0;
    } else if (currentRoute == '/configure-pickers') {
      _selectedIndex = 1;
    } else if (currentRoute == '/trends') {
      _selectedIndex = 2;
    }

    return BottomNavigationBar(
      backgroundColor: Colors.grey[400],
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_applications, color: Colors.black),
          label: 'Configure Pickers',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined, color: Colors.black),
          label: 'Charts',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}

