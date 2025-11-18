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
    return Hero(
      id: json['id'],
      name: json['name'],
      localizedName: json['localized_name'],
      primaryAttr: json['primary_attr'],
      attackType: json['attack_type'],
      roles: List<String>.from(json['roles']),
      img: json['img'],
      icon: json['icon'],
    );
  }
}