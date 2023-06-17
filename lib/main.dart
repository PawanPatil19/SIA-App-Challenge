import 'package:flutter/material.dart';
import 'package:sia_app/views/layout.dart';
import 'package:sia_app/views/login_page.dart';
import 'package:sia_app/views/register_page_part1.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:sia_app/views/register_page_part2.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kris+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Fredoka'
      ),
      initialRoute: 'home_screen',
      routes: {
        'home_screen': (context) => const Layout(),
        'login_page': (context) => const LoginPage(),
        'register_page': (context) => const RegisterMerchantPage(),
        'register_page2': (context) => const RegisterMerchantPage2(),
      },
      home: const Layout()
  
    );
  }
}