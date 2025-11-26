import 'package:flutter/material.dart';
import '../models/dota_hero.dart';
import '../models/matchup.dart';
import '../services/api_service.dart';

class HeroDetailScreen extends StatefulWidget {
  final DotaHero hero;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const HeroDetailScreen({
    Key? key,
    required this.hero,
    required this.isFavorite,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  _HeroDetailScreenState createState() => _HeroDetailScreenState();
}

class _HeroDetailScreenState extends State<HeroDetailScreen> {
  List<Matchup>? _matchups;
  Map<int, DotaHero>? _heroMap;
  bool _loading = true;
  String? _error;
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    _loadMatchups();
  }

  Future<void> _loadMatchups() async {
    try {
      final matchups = await ApiService.getHeroMatchups(widget.hero.id);
      final heroes = await ApiService.fetchHeroes();

      final map = {for (var h in heroes) h.id: h};

      matchups.sort((a, b) => b.gamesPlayed.compareTo(a.gamesPlayed));

      setState(() {
        _matchups = matchups;
        _heroMap = map;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  // --- UI HELPERS ---------------------------------------------------------

  Widget _statRow(String name, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(color: Colors.grey[300])),
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _roleTag(String role) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.tealAccent.withOpacity(0.85),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        role.toUpperCase(),
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  // --- MATCHUPS UI --------------------------------------------------------

  Widget _buildMatchupsList() {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator(color: Colors.tealAccent)),
      );
    }

    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text("Erreur : $_error", style: const TextStyle(color: Colors.redAccent)),
      );
    }

    if (_matchups == null || _matchups!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text("Aucun matchup trouvé.", style: TextStyle(color: Colors.white70)),
      );
    }

    final items = _matchups!.take(15).toList();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) =>
          Divider(color: Colors.white.withOpacity(0.08), height: 20),
      itemBuilder: (context, index) {
        final m = items[index];
        final opponent = _heroMap![m.heroId];

        if (opponent == null) {
          return Text("Héros inconnu ${m.heroId}",
              style: const TextStyle(color: Colors.white70));
        }

        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                opponent.fullIconUrl,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(opponent.localizedName,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("${m.gamesPlayed} parties",
                      style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("${m.winrate.toStringAsFixed(1)}%",
                    style: const TextStyle(
                        color: Colors.tealAccent, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("winrate",
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ],
        );
      },
    );
  }

  // --- BUILD --------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final hero = widget.hero;

    return Scaffold(
      backgroundColor: const Color(0xff1B1F23),
      appBar: AppBar(
        backgroundColor: const Color(0xff111417),
        title: Text(hero.localizedName),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              widget.onFavoriteToggle();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // ⭐ Background image
          Positioned.fill(
            child: Image.network(
              hero.fullImgUrl, 
              fit: BoxFit.cover,
              // Fallback en cas d'erreur de chargement
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey[800]);
              },
            ),
          ),

          // ⭐ Semi-clear filter
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.22)),
          ),

          // ⭐ Main content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rôles
                Wrap(
                  children: hero.roles.map((r) => _roleTag(r)).toList(),
                ),
                const SizedBox(height: 16),

                // STATS
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.50),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Statistiques',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      _statRow('HP', '${hero.baseHealth} (+${hero.baseHealthRegen}/s)'),
                      _statRow('Mana', '${hero.baseMana} (+${hero.baseManaRegen}/s)'),
                      _statRow('Force', '${hero.baseStr} (+${hero.strGain})'),
                      _statRow('Agilité', '${hero.baseAgi} (+${hero.agiGain})'),
                      _statRow('Intelligence', '${hero.baseInt} (+${hero.intGain})'),
                      _statRow('Dégâts', '${hero.baseAttackMin} - ${hero.baseAttackMax}'),
                      _statRow('Armure', '${hero.baseArmor}'),
                      _statRow('Portée', '${hero.attackRange}'),
                      _statRow('Vitesse', '${hero.moveSpeed}'),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // MATCHUPS
                const Text(
                  "Matchups",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _buildMatchupsList(),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}