

import 'package:api_dota/providers/hero_provider.dart';
import 'package:api_dota/screens/hero_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeroListScreen extends StatelessWidget {
  const HeroListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dota 2 Heroes'),
      ),
      body: Consumer<HeroProvider>(
        builder: (context, heroProvider, child) {
          if (heroProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: heroProvider.heroes.length,
            itemBuilder: (context, index) {
              final hero = heroProvider.heroes[index];
              return ListTile(
                leading: Image.network(
                  'https://api.opendota.com${hero.icon}',
                  width: 40,
                  height: 40,
                ),
                title: Text(hero.localizedName),
                subtitle: Text(hero.primaryAttr),
                onTap: () {
                  // Naviguer vers la page de détails
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HeroDetailScreen(hero: hero),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}