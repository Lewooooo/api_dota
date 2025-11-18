import 'package:api_dota/models/hero.dart';
import 'package:api_dota/services/api_service.dart';
import 'package:flutter/material.dart' hide Hero;

class HeroDetailScreen extends StatefulWidget {
  final Hero hero;

  const HeroDetailScreen({Key? key, required this.hero}) : super(key: key);

  @override
  _HeroDetailScreenState createState() => _HeroDetailScreenState();
}

class _HeroDetailScreenState extends State<HeroDetailScreen> {
  Map<String, dynamic>? _heroStats;

  @override
  void initState() {
    super.initState();
    _loadHeroStats();
  }

  Future<void> _loadHeroStats() async {
    try {
      final stats = await ApiService.getHeroStats(widget.hero.id);
      setState(() {
        _heroStats = stats;
      });
    } catch (error) {
      print('Error loading hero stats: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.hero.localizedName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              // dans HeroDetailScreen (Image.network)
              child: widget.hero.img.isNotEmpty
                  ? Image.network(
                      'https://api.opendota.com${widget.hero.img}',
                      height: 200,
                    )
                  : Container(
                      height: 200,
                      child: Icon(Icons.image_not_supported, size: 64),
                    ),
            ),
            SizedBox(height: 20),
            Text('Attribut principal: ${widget.hero.primaryAttr}'),
            Text('Type d\'attaque: ${widget.hero.attackType}'),
            Text('Rôles: ${widget.hero.roles.join(', ')}'),
            SizedBox(height: 20),
            if (_heroStats != null) ...[
              Text(
                'Statistiques:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Winrate: ${(_heroStats!['win_rate'] * 100).toStringAsFixed(2)}%',
              ),
              Text(
                'Popularité: ${_heroStats!['pick_rate'].toStringAsFixed(2)}%',
              ),
            ] else
              CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
