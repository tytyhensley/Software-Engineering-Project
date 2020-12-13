import 'package:flutter/material.dart';
import 'package:aloneless_app/screens/startup/welcomescreen.dart';
import 'package:aloneless_app/screens/startup/login_screen.dart';
import 'package:aloneless_app/screens/startup/forgotpassword_screen.dart';
import 'package:aloneless_app/screens/startup/registration_screen.dart';
import 'package:aloneless_app/screens/emotion/calendar_screen.dart';
import 'package:aloneless_app/screens/emotion/emotiontracker1_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomePage(),
        'login_screen': (context) => LoginPage(),
        'forgotpass_screen': (context) => ForgotPassword(),
        'registration_screen': (context) => RegistrationScreen(),
        'calendar_screen': (context) => Calendar(),
        'emotion1_screen': (context) => Emotion1(),
      },
    );
  }
}
