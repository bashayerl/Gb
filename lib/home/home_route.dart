import 'package:flutter/material.dart';
import 'package:fapp/home/home_page.dart';
import 'package:fapp/home/profile_page.dart';
import 'package:fapp/home/search_page.dart';
import 'package:fapp/home/training_courses_page.dart';
import 'package:fapp/home/event_page.dart';

void main() => runApp(const HomeRoute());

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  static const String _title = 'Home';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  String _title = "Home";
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    EventPage(),
    SearchPage(),
    TrainingCoursesScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          {
            _title = 'Home';
          }
          break;
        case 1:
          {
            _title = 'Event';
          }
          break;
        case 2:
          {
            _title = 'Search';
          }
          break;
        case 3:
          {
            _title = 'Training Courses';
          }
          break;

        case 4:
          {
            _title = 'Profile';
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_sharp),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(58, 66, 86, 1.0),
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(size: 30),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: _onItemTapped,
      ),
    );
  }
}
