import 'package:flutter/material.dart';

import 'package:trackncheck/Home.dart';
import 'package:trackncheck/account.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/history.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    Center(child: Text("Ai")),
    ScanHistoryPage(),
    UserAccountPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        backgroundColor: Color(0xff101729),
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: ColorConstants.mainColor,
        unselectedItemColor: const Color.fromARGB(255, 102, 99, 99),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree_outlined),
            label: 'Ai Assistant',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
