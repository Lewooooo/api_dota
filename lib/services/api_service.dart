import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dota_hero.dart';
import '../models/matchup.dart';

class ApiService {
  static const String _base = 'https://api.opendota.com/api';

  // Récupère la liste complète des héros (utilisé pour mapper hero_id → nom/icon)
  static Future<List<DotaHero>> fetchHeroes() async {
    final res = await http.get(Uri.parse('$_base/heroStats'));
    if (res.statusCode == 200) {
      final List<dynamic> data = json.decode(res.body);
      return data.map((e) => DotaHero.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch heroes');
    }
  }

  // Récupère les matchups pour un hero donné
  static Future<List<Matchup>> getHeroMatchups(int heroId) async {
    final res = await http.get(Uri.parse('$_base/heroes/$heroId/matchups'));
    if (res.statusCode == 200) {
      final List<dynamic> data = json.decode(res.body);
      return data.map((e) => Matchup.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch matchups');
    }
  }
}
