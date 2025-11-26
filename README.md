# 🎮 **Dota 2 Heroes App**

Une application **Flutter** moderne permettant d’explorer les héros de *Dota 2* avec leurs statistiques complètes, leurs rôles et leurs matchups — alimentée par l’API **OpenDota**.

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/c/c2/Dota_logo.svg" width="120" />
</p>

---

# 🖼️ **Aperçu de l'application**

<div align="center" style="display:flex; justify-content:center; gap:25px;">

  <div>
    <img width="250" alt="heroes_list" src="https://github.com/user-attachments/assets/869bc720-11b7-4315-b95d-4eb85935121c" />
    <p><strong>Liste des héros</strong></p>
  </div>

  <div>
    <img width="250" alt="favoris" src="https://github.com/user-attachments/assets/02bfa903-be6a-4e4b-a015-2b96277b9d1c" />
    <p><strong>Écran des favoris</strong></p>
  </div>

  <div>
    <img width="250" alt="hero_detail" src="https://github.com/user-attachments/assets/0d89539c-6e6b-48ea-8a8a-9ad87a828a6a" />
    <p><strong>Détails d’un héro</strong></p>
  </div>

</div>


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


