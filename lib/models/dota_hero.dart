class DotaHero {
  final int id;
  final String name;
  final String localizedName;
  final String primaryAttr;
  final String attackType;
  final List<String> roles;
  final String img;
  final String icon;

  // Stats
  final int baseHealth;
  final double baseHealthRegen;
  final int baseMana;
  final double baseManaRegen;
  final int baseArmor;
  final int baseMagicResist;
  final int baseAttackMin;
  final int baseAttackMax;
  final int attackRange;
  final int projectileSpeed;
  final double attackRate;
  final int baseStr;
  final int baseAgi;
  final int baseInt;
  final double strGain;
  final double agiGain;
  final double intGain;
  final int moveSpeed;
  final double turnRate;

  DotaHero({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.primaryAttr,
    required this.attackType,
    required this.roles,
    required this.img,
    required this.icon,
    required this.baseHealth,
    required this.baseHealthRegen,
    required this.baseMana,
    required this.baseManaRegen,
    required this.baseArmor,
    required this.baseMagicResist,
    required this.baseAttackMin,
    required this.baseAttackMax,
    required this.attackRange,
    required this.projectileSpeed,
    required this.attackRate,
    required this.baseStr,
    required this.baseAgi,
    required this.baseInt,
    required this.strGain,
    required this.agiGain,
    required this.intGain,
    required this.moveSpeed,
    required this.turnRate,
  });

  String get fullImgUrl => 'https://cdn.cloudflare.steamstatic.com$img';
  String get fullIconUrl => 'https://cdn.cloudflare.steamstatic.com$icon';

  factory DotaHero.fromJson(Map<String, dynamic> json) {
    num safeNum(dynamic v) => v is num ? v : num.tryParse('$v') ?? 0;
    List<String> safeRoles(dynamic r) {
      if (r == null) return [];
      try {
        return List<String>.from(r);
      } catch (_) {
        return [];
      }
    }

    return DotaHero(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      localizedName: json['localized_name'] ?? '',
      primaryAttr: json['primary_attr'] ?? '',
      attackType: json['attack_type'] ?? '',
      roles: safeRoles(json['roles']),
      img: json['img'] ?? '',
      icon: json['icon'] ?? '',
      baseHealth: safeNum(json['base_health']).toInt(),
      baseHealthRegen: safeNum(json['base_health_regen']).toDouble(),
      baseMana: safeNum(json['base_mana']).toInt(),
      baseManaRegen: safeNum(json['base_mana_regen']).toDouble(),
      baseArmor: safeNum(json['base_armor']).toInt(),
      baseMagicResist: safeNum(json['base_mr']).toInt(),
      baseAttackMin: safeNum(json['base_attack_min']).toInt(),
      baseAttackMax: safeNum(json['base_attack_max']).toInt(),
      attackRange: safeNum(json['attack_range']).toInt(),
      projectileSpeed: safeNum(json['projectile_speed']).toInt(),
      attackRate: safeNum(json['attack_rate']).toDouble(),
      baseStr: safeNum(json['base_str']).toInt(),
      baseAgi: safeNum(json['base_agi']).toInt(),
      baseInt: safeNum(json['base_int']).toInt(),
      strGain: safeNum(json['str_gain']).toDouble(),
      agiGain: safeNum(json['agi_gain']).toDouble(),
      intGain: safeNum(json['int_gain']).toDouble(),
      moveSpeed: safeNum(json['move_speed']).toInt(),
      turnRate: safeNum(json['turn_rate']).toDouble(),
    );
  }
}
