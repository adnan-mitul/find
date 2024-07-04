import 'package:findhome/views/notification.dart' as custom;
import 'package:findhome/views/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:findhome/views/settings.dart';
import 'package:findhome/views/messages.dart';
import 'package:findhome/views/welcome.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Welcome(),
    custom.Notification(), // Use the custom prefix to avoid conflict
    Messages(),
    Profile(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 0 : 16), // Adjust padding as needed
        child: CurvedNavigationBar(
          index: _selectedIndex,
          color: Colors.lightBlueAccent,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          animationDuration: Duration(milliseconds: 300),
          height: 60,
          items: <Widget>[
            Icon(Icons.home,
                size: 30,
                color: _selectedIndex == 0 ? Color(0xFF21a663) : Colors.black),
            Icon(Icons.notifications_active_sharp,
                size: 30,
                color: _selectedIndex == 1 ? Color(0xFF21a663) : Colors.black),
            Icon(Icons.import_contacts_sharp,
                size: 30,
                color: _selectedIndex == 2 ? Color(0xFF21a663) : Colors.black),
            Icon(Icons.people_alt_sharp,
                size: 30,
                color: _selectedIndex == 3 ? Color(0xFF21a663) : Colors.black),
            Icon(Icons.settings,
                size: 30,
                color: _selectedIndex == 4 ? Color(0xFF21a663) : Colors.black),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
