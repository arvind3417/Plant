import 'package:flutter/material.dart';
import 'package:news/screens/bottomnavbarscreens/imagepicker.dart';
import 'package:news/screens/bottomnavbarscreens/livemap.dart';
import 'package:news/screens/bottomnavbarscreens/profile.dart';
import 'package:news/screens/bottomnavbarscreens/update.dart';
import 'package:news/screens/bottomnavbarscreens/plants_add.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static  List<Widget> pages = <Widget>[
    livemap(), imagePickerScreen(), UpdateScreen(), ProfilePage()

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Container(
        color: Colors.black,
        child: Center(
          child: pages.elementAt(_selectedIndex),
        ),
      ),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
            primaryColor: Colors.white,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.grey))),
        child: BottomNavigationBar(
          backgroundColor: Colors.red,
          showSelectedLabels: false,
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),

              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
