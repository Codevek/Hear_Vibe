import 'package:flutter/material.dart';
import 'package:vibehear/pages/home.dart';
import 'package:vibehear/pages/intro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;

  final firstName = prefs.getString('firstName') ?? '';
  final middleName = prefs.getString('middleName') ?? '';
  final lastName = prefs.getString('lastName') ?? '';
  final nickName = prefs.getString('nickName') ?? '';

  runApp(MyApp(
    isFirstTime: isFirstTime,
    firstName: firstName,
    middleName: middleName,
    lastName: lastName,
    nickName: nickName,
  ));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  final String firstName;
  final String middleName;
  final String lastName;
  final String nickName;

  const MyApp({
    super.key,
    required this.isFirstTime,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.nickName,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isFirstTime
          ? const IntroPage()
          : Home(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        nickName: nickName,
      ),
    );
  }
}