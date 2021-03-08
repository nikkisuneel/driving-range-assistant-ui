/*
 * Copyright (c) 2021, Nikhila (Nikki) Suneel. All Rights Reserved.
 */

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
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_applications),
          label: 'Pickers',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined),
          label: 'Charts',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}

