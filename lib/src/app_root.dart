import 'package:fixit/views/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const
      SplashScreen(),
      theme: ThemeData(
        fontFamily: 'ReadexPro',
      ),
    );
  }
}
