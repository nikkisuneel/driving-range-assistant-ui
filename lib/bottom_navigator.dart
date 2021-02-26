import 'package:flutter/material.dart';
import 'utils.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  Future<void> _onItemTapped(int index) async {
    switch(index) {
      case 0:
        bool b = await isPhysicalDevice();
        if (b) {
          Navigator.pushNamed(context, "/take-picture");
        } else {
          Navigator.pushNamed(context, "/dummy-fixed-image");
        }
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

    if (currentRoute == '/fixed-image' || currentRoute == '/dummy-fixed-image') {
      _selectedIndex = 0;
    } else if (currentRoute == '/configure-pickers') {
      _selectedIndex = 1;
    } else if (currentRoute == '/trends') {
      _selectedIndex = 2;
    }

    return BottomNavigationBar(
      backgroundColor: Colors.grey[800],
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_applications, color: Colors.white),
          label: 'Configure Pickers',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined, color: Colors.white),
          label: 'Charts',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white38,
      unselectedItemColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}

