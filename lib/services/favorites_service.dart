import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites';

  static Future<void> addFavorite(int heroId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.add(heroId);
    await prefs.setStringList(_favoritesKey, favorites.map((id) => id.toString()).toList());
  }

  static Future<void> removeFavorite(int heroId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.remove(heroId);
    await prefs.setStringList(_favoritesKey, favorites.map((id) => id.toString()).toList());
  }

  static Future<Set<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_favoritesKey) ?? [];
    return list.map((idStr) => int.tryParse(idStr) ?? 0).where((id) => id != 0).toSet();
  }

  static Future<bool> isFavorite(int heroId) async {
    final favorites = await getFavorites();
    return favorites.contains(heroId);
  }
}