# MediStock IoT — Application Mobile Flutter

## Description
Prototype statique Flutter de l'application MediStock IoT.
Système de gestion de stock pharmaceutique et de contrôle environnemental.

## Projet Tutoré — L2 Informatique de Gestion — UCAO Dakar 2025-2026

## Stack
- Flutter 3.10+ / Dart 3.0+
- fl_chart (graphiques)
- google_fonts (Inter)
- Données statiques (mock_data.dart)

## Structure
```
lib/
├── main.dart                   # Point d'entrée + routing
├── theme/
│   └── app_theme.dart          # Design system complet (couleurs, styles, décorations)
├── data/
│   └── mock_data.dart          # Toutes les données statiques de démonstration
├── widgets/
│   ├── sidebar.dart            # Barre de navigation latérale
│   └── top_bar.dart            # TopBar + widgets partagés (KpiCard, StatusBadge, etc.)
└── screens/
    ├── login_screen.dart                         # Écran 1 : Connexion
    ├── dashboard_screen.dart                     # Écran 2 : Tableau de bord
    ├── inventaire_screen.dart                    # Écran 3 : Inventaire
    ├── fiche_mouvement_temperature.dart          # Écrans 4, 5, 6 : Fiche, Mouvement, Température
    └── alertes_rapports_parametres_profil.dart  # Écrans 7, 8, 9, 10 : Alertes, Rapports, Paramètres, Profil
```

## Installation

### Prérequis
- Flutter SDK 3.10.0 ou supérieur
- Dart SDK 3.0.0 ou supérieur
- Android Studio ou VS Code avec extension Flutter

### Lancer l'application
```bash
# Installer les dépendances
flutter pub get

# Lancer en mode web (recommandé pour prototype desktop)
flutter run -d chrome

# Lancer sur Android
flutter run -d android

# Build APK
flutter build apk --release
```

## Écrans disponibles
| Route | Écran | Description |
|---|---|---|
| `/` | Connexion | Login avec sélection de rôle |
| `/dashboard` | Tableau de bord | KPIs, graphiques, accès rapide |
| `/inventaire` | Inventaire | Liste médicaments avec filtres |
| `/fiche` | Fiche médicament | Détail Insuline Lantus |
| `/mouvement` | Mouvement stock | Formulaire entrée/sortie |
| `/temperature` | Surveillance | Graphiques température/humidité |
| `/alertes` | Alertes | Liste actives + historique |
| `/rapports` | Rapports | 6 types + rapports récents |
| `/parametres` | Paramètres | Seuils capteurs + utilisateurs |
| `/profil` | Profil | Compte + notifications |

## Notes de développement
- Toutes les données sont statiques (mock_data.dart)
- La navigation est gérée par AppShell dans main.dart
- Pour dynamiser : remplacer MockData par des appels API REST (Dio)
- Le design suit fidèlement les maquettes Figma du prototype
