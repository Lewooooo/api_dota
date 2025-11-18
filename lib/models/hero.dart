class Hero {
  final int id;
  final String name;
  final String localizedName;
  final String primaryAttr;
  final String attackType;
  final List<String> roles;
  final String img;
  final String icon;

  Hero({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.primaryAttr,
    required this.attackType,
    required this.roles,
    required this.img,
    required this.icon,
  });

  factory Hero.fromJson(Map<String, dynamic> json) {
    // utilitaire pour récupérer une chaîne sûre
    String _safeString(dynamic v) => v == null ? '' : v.toString();

    // récupérer roles en List<String> sûre
    List<String> _safeRoles(dynamic r) {
      if (r == null) return <String>[];
      try {
        return List<String>.from((r as List).map((e) => e.toString()));
      } catch (_) {
        return <String>[];
      }
    }

    return Hero(
      id: (json['id'] is int) ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      name: _safeString(json['name']),
      localizedName: _safeString(json['localized_name']),
      primaryAttr: _safeString(json['primary_attr']),
      attackType: _safeString(json['attack_type']),
      roles: _safeRoles(json['roles']),
      img: _safeString(json['img']),
      icon: _safeString(json['icon']),
    );
  }
}
