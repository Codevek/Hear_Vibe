import 'package:flutter/material.dart';
import 'package:vibehear/components/bottom_nav_bar.dart';
import 'package:vibehear/pages/about_page.dart';
import 'package:vibehear/pages/home_page.dart';
import 'package:vibehear/pages/settings_page.dart';
import 'package:vibehear/pages/setup_page.dart';
import 'package:vibehear/pages/support.dart';
import 'package:vibehear/pages/transcript_page.dart';
import 'package:vibehear/pages/vibration_page.dart';

class Home extends StatefulWidget {
  final String firstName;
  final String middleName;
  final String lastName;
  final String nickName;

  const Home({
    super.key,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.nickName,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // bottom nav bar control
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // pages to display
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      HomePage(
        firstName: widget.firstName,
        middleName: widget.middleName,
        lastName: widget.lastName,
        nickName: widget.nickName,
      ),
      const VibrationPage(),
      const TranscriptPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
      backgroundColor: Color.fromRGBO(242, 250, 255, 1),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Icon(
                    Icons.menu,
                  color: Colors.grey.shade800,
                ),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }
        ),
        title: Transform.translate(
          offset: Offset(-12, 0),
          child: Text(
              'Vibe Hear',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue[50],
        child: Column(
          children: [
            // logo
            DrawerHeader(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Image.asset('lib/images/logo_vibe_hear.png'),
                )
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SetupPage()
                    ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: ListTile(
                  leading: Icon(Icons.person_2),
                  title: Text('Profile'),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                    ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Support()
                    ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListTile(
                      leading: Icon(Icons.headset_mic),
                  title: Text('Support'),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutPage(),
                    ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
