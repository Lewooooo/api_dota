import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/hero_provider.dart';
import 'screens/hero_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HeroProvider()..fetchHeroes(),
      child: MaterialApp(
        title: 'OpenDota App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HeroListScreen(),
      ),
    );
  }
}