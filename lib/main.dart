import 'package:flutter/material.dart';
import 'package:sia_app/views/layout.dart';
import 'package:sia_app/views/login_page.dart';

void main() {
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
        
      },
      home: const Layout()
  
    );
  }
}