import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NavPae extends StatefulWidget {
  const NavPae({Key? key}) : super(key: key);

  @override
  State<NavPae> createState() => _NavPaeState();
}

class _NavPaeState extends State<NavPae> {
  List page = [
    Center(child: Text("Hello")),
    Center(child: Text("Hello1")),
    Center(child: Text("Hello2")),
    Center(child: Text("Hello3")),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: "archive"),
          BottomNavigationBarItem(
              icon: Icon(Icons.architecture), label: "architecture"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "call"),
        ],
      ),
    );
  }

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }
}
