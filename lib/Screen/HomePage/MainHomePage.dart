import 'package:flutter/material.dart';

import '../../Constant.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int selectedIndex = 0; // Track the selected index

  // List of widgets representing different pages
  final List<Widget> _pages = <Widget>[
    const Center(child: Text('Nearby')),
    const Center(child: Text('Moments')),
    const Center(child: Text('Chats')),
    const Center(child: Text('Profile')),
    const Center(child: Text('Settings')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index; // Update the index when a new tab is selected
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: _pages[selectedIndex], // Display the selected page
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: _onItemTapped, // Handle tap
          indicatorColor: labelColor.withOpacity(0.1),
          
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.location_pin,
                size: 28,
                color: selectedIndex == 0 ? labelColor : secondaryBackground,
              ),
              label: 'Nearby',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.aod_sharp,
                color: selectedIndex == 1 ? labelColor : secondaryBackground,
              ),
              label: 'Moments',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.wechat_rounded,
                color: selectedIndex == 2 ? labelColor : secondaryBackground,
              ),
              label: 'Chats',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person,
                color: selectedIndex == 3 ? labelColor : secondaryBackground,
              ),
              label: 'Profile',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings_outlined,
                color: selectedIndex == 4 ? labelColor : secondaryBackground,
              ),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}
/*

void vcall() {
  Tab(
    text: 'Nearby',
    icon: Icon(
      Icons.location_pin,
      size: 28,
    ),
  )
  ,
  Tab(
  text: 'Moments',
  icon: Icon(
  Icons.aod_sharp,
  size: 28,
  ),
  ),
  Tab(
  text: 'Chats',
  icon: Icon(
  Icons.wechat_rounded,
  size: 28,
  ),
  ),
  Tab(
  text: 'Friend',
  icon: Icon(
  Icons.person,
  size: 28,
  ),
  ),
  Tab(
  text: 'Settings',
  icon: Icon(
  Icons.settings_outlined,
  size: 28
  ,
  )
  ,
  )
  ,
}*/
