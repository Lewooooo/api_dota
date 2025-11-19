import 'package:flutter/material.dart';
import 'screens/hero_list_screen.dart';

void main() => runApp(DotaApp());

class DotaApp extends StatelessWidget {
  const DotaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dota 2 Heroes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HeroListScreen(),
    );
  }
}
