class Matchup {
  final int heroId;
  final int gamesPlayed;
  final int wins;

  Matchup({
    required this.heroId,
    required this.gamesPlayed,
    required this.wins,
  });

  double get winrate =>
      gamesPlayed == 0 ? 0.0 : (wins / gamesPlayed) * 100.0;

  factory Matchup.fromJson(Map<String, dynamic> json) {
    return Matchup(
      heroId: json['hero_id'] ?? 0,
      gamesPlayed: json['games_played'] ?? 0,
      wins: json['wins'] ?? 0,
    );
  }
}
