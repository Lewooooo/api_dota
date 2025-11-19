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
  Set<String> selectedRoles = {}; // Multi-select roles
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

          // --- Liste unique des rôles ---
          final allRoles = <String>{};
          for (var h in heroes) {
            allRoles.addAll(h.roles);
          }
          final rolesList = allRoles.toList()..sort();

          // --- Filtrage multi-roles + recherche ---
          List<DotaHero> filtered = heroes.where((h) {
            final matchSearch = h.localizedName.toLowerCase().contains(
              searchQuery.toLowerCase(),
            );

            // Tous les rôles sélectionnés doivent être présents dans h.roles
            final matchRole =
                selectedRoles.isEmpty ||
                selectedRoles.every((r) => h.roles.contains(r));

            return matchSearch && matchRole;
          }).toList();

          return Column(
            children: [
              /// --- Barre de recherche ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
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

              /// --- Tags multi-sélection des rôles ---
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: rolesList.map((role) {
                    final selected = selectedRoles.contains(role);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selected) {
                            selectedRoles.remove(role);
                          } else {
                            selectedRoles.add(role);
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.tealAccent.withOpacity(0.9)
                              : Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          role.toUpperCase(),
                          style: TextStyle(
                            color: selected ? Colors.black : Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 10),

              /// --- Grid des héros ---
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
                              builder: (_) => HeroDetailScreen(hero: hero),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.05),
                                Colors.white.withOpacity(0.15),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              ),
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
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: hero.roles
                                    .map(
                                      (r) => Container(
                                        margin: const EdgeInsets.only(right: 4),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.tealAccent.withOpacity(
                                            0.7,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Text(
                                          r.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
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
