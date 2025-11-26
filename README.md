<img width="1915" height="998" alt="Copie d&#39;écran_20251126_143445" src="https://github.com/user-attachments/assets/1e39319f-4932-4c1d-bd9d-b19a06e08da7" /># 🎮 **Dota 2 Heroes App**

Une application **Flutter** moderne permettant d’explorer les héros de *Dota 2* avec leurs statistiques complètes, leurs rôles et leurs matchups — alimentée par l’API **OpenDota**.

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/c/c2/Dota_logo.svg" width="120" />
</p>

---

# 🖼️ **Aperçu de l'application**

![Uploading Copie d'écran_20251126_143445.png…]()

---

## ✨ **Fonctionnalités**

### 🧙 Liste complète des héros

* Affichage en **grid responsive**
* Icônes HD + rôles principaux

### 🔍 Recherche & filtres avancés

* Recherche instantanée par nom
* **Filtrage multi-rôles** (Carry, Support, Nuker, etc.)

### ⭐ Favoris persistants

* Sauvegarde locale avec `SharedPreferences`
* Section dédiée aux héros favoris

### 📊 Stats détaillées

* Détails complets du héros : attributs, croissance, rôles
* Graphiques et présentation propre

### ⚔️ Matchups Dota 2

* Analyse des **winrates** contre chaque héros
* Classement des meilleurs et pires matchups

### 🌙 Thème sombre gaming

* UI pensée pour l'immersion
* Design cohérent et épuré

---

## 🛠️ **Installation**

### 📦 Prérequis

* **Flutter SDK 3.9.2+**
* Android Studio / VS Code
* Émulateur ou appareil physique

### 🚀 Installation du projet

```bash
git clone <votre-repo>
cd dota_heroes
flutter pub get
```

### ▶️ Lancer l’application

```bash
flutter run
```

---

## 🗂️ **Organisation du projet**

```
lib/
 ├── models/        # Modèles OpenDota (Hero, Stats, Matchups…)
 ├── screens/       # Pages de l'application
 ├── services/      # Appels API OpenDota
 └── main.dart
```

---

## 📡 **API utilisée**

* **OpenDota API** – [https://docs.opendota.com](https://docs.opendota.com)
  (Gratuite, rapide et sans clé d’API)

---

## 🤝 Contribution

Les PR sont les bienvenues !
N’hésite pas à ouvrir une issue pour proposer des idées ou signaler un bug.

---

## 📜 Licence

Ce projet est sous licence **MIT** — libre d’utilisation et de modification.

---


