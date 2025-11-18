

import 'package:api_dota/models/hero.dart';
import 'package:api_dota/services/api_service.dart';
import 'package:flutter/material.dart' hide Hero;

class HeroProvider with ChangeNotifier {
  List<Hero> _heroes = [];
  bool _isLoading = false;

  List<Hero> get heroes => _heroes;
  bool get isLoading => _isLoading;

  Future<void> fetchHeroes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _heroes = await ApiService.getHeroes();
    } catch (error) {
      print('Error fetching heroes: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}