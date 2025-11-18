import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hero.dart';

class ApiService {
  static const String _baseUrl = 'https://api.opendota.com/api';

  static Future<List<Hero>> getHeroes() async {
    final response = await http.get(Uri.parse('$_baseUrl/heroes'));
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((json) => Hero.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load heroes');
    }
  }

  static Future<Map<String, dynamic>> getHeroStats(int heroId) async {
    final response = await http.get(Uri.parse('$_baseUrl/heroes/$heroId/stats'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load hero stats');
    }
  }
}