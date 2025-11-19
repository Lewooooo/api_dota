import 'package:flutter/material.dart';
import '../models/dota_hero.dart';
import '../services/api_service.dart';
import 'hero_detail_screen.dart';

class HeroListScreen extends StatefulWidget {
  const HeroListScreen({Key? key}) : super(key: key);

  @override
  _HeroListScreenState createState() => _HeroListScreenState();
}

class _HeroListScreenState extends State<HeroListScreen> {
  late Future<List<DotaHero>> _futureHeroes;
  String selectedRole = 'All';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _futureHeroes = ApiService.fetchHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1B1F23),
      appBar: AppBar(
        title: const Text('Dota 2 Heroes'),
        backgroundColor: const Color(0xff111417),
      ),
      body: FutureBuilder<List<DotaHero>>(
        future: _futureHeroes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          final heroes = snapshot.data ?? [];

          /// --- Liste des rôles ---
          final roles = ['All'];
          for (final h in heroes) {
            for (final r in h.roles) {
              if (!roles.contains(r)) roles.add(r);
            }
          }

          /// --- Filtre rôle + recherche ---
          List<DotaHero> filtered = heroes.where((h) {
            final matchRole =
                selectedRole == 'All' || h.roles.contains(selectedRole);
            final matchSearch = h.localizedName
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
            return matchRole && matchSearch;
          }).toList();

          return Column(
            children: [
              /// --- Recherche ---
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Rechercher un héros...",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: const Color(0xff252B30),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (val) => setState(() => searchQuery = val),
                ),
              ),

              /// --- Filtre rôle ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<String>(
                  value: selectedRole,
                  dropdownColor: const Color(0xff252B30),
                  isExpanded: true,
                  items: roles
                      .map((r) => DropdownMenuItem(
                            value: r,
                            child: Text(r,
                                style: const TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => selectedRole = val ?? 'All'),
                ),
              ),

              const SizedBox(height: 10),

              /// --- Grid moderne ---
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                    itemCount: filtered.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 140,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final hero = filtered[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    HeroDetailScreen(hero: hero)),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.05),
                                Colors.white.withOpacity(0.15)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  hero.fullIconUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                hero.localizedName,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: hero.roles
                                    .map((r) => Container(
                                          margin:
                                              const EdgeInsets.only(right: 4),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.tealAccent
                                                .withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            r.toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
