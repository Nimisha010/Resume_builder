/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:resume_app/Screen/selection_page.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
//import 'screen/selection_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/login': (context) => const LoginPage(),
        '/resume_selection': (context) => const ResumeSelectionPage(),
      },
      home: const LoginPage(),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:resume_app/Screen/selection_page.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
//import 'screen/selection_page.dart';
import 'screen/create_resume_page.dart'; // Import the create resume page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/login': (context) => const LoginPage(),
        '/resume_selection': (context) => const ResumeSelectionPage(),
        '/create_resume': (context) => const CreateResumePage(),
      },
      home: const LoginPage(),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screen/login_page.dart';
import 'screen/splash_screen.dart'; // Import Splash Screen
import 'screen/selection_page.dart';
import 'screen/create_resume_page.dart'; // Import Create Resume Page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/login': (context) => const LoginPage(),
        '/resume_selection': (context) => const ResumeSelectionPage(),
        '/create_resume': (context) => const CreateResumePage(),
      },
      home: const SplashScreen(), // Start with Splash Screen
    );
  }
}
