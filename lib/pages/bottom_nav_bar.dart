import 'package:flutter/material.dart';
import 'package:swap_cust_app/pages/notification_page.dart';
import 'package:swap_cust_app/pages/shortlist_page.dart';
import 'package:swap_cust_app/pages/history_page.dart';
import 'package:swap_cust_app/pages/home_page.dart';
import 'package:swap_cust_app/pages/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomePage(),
    ShortlistPage(),
    NotificationPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  List<String> labelText = [
    'Home',
    'favorite',
    'Notifications',
    'History',
    'Profile'
  ];

  List<Widget> bottomNavIcon = [
    Icon(Icons.home),
    Icon(Icons.favorite),
    Icon(Icons.notifications),
    Icon(Icons.history),
    Icon(Icons.person),
  ];

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: changeIndex,
        items: List.generate(
          labelText.length,
          (index) => BottomNavigationBarItem(
              icon: bottomNavIcon[index], label: labelText[index]),
        ),
      ),
      body: pages[currentIndex],
    );
  }
}
