import '../theme/app_theme.dart';
import 'package:flutter/material.dart';

// ── Medicament model ──────────────────────────────────────────
class Medicament {
  final String nom;
  final String cip;
  final String categorie;
  final String zone;
  final int stock;
  final StatutStock statut;
  final String expiration;
  final String? joursExpiration;

  const Medicament({
    required this.nom, required this.cip, required this.categorie,
    required this.zone, required this.stock, required this.statut,
    required this.expiration, this.joursExpiration,
  });
}

enum StatutStock { ok, rupture, stockBas, expireBientot }

// ── Alerte model ──────────────────────────────────────────────
class Alerte {
  final NiveauAlerte niveau;
  final String type;
  final String description;
  final String localisation;
  final String horodatage;
  final bool peutAccuser;

  const Alerte({
    required this.niveau, required this.type, required this.description,
    required this.localisation, required this.horodatage, required this.peutAccuser,
  });
}

enum NiveauAlerte { critique, avertissement, stockBas, systeme }

// ── Capteur seuil model ───────────────────────────────────────
class CapteurSeuil {
  final String nom;
  final String zone;
  final double seuilBas;
  final double seuilHaut;
  final String unite;
  final bool actif;

  const CapteurSeuil({
    required this.nom, required this.zone, required this.seuilBas,
    required this.seuilHaut, required this.unite, required this.actif,
  });
}

// ── Utilisateur model ─────────────────────────────────────────
class UtilisateurItem {
  final String nom;
  final String role;
  final Color roleColor;

  const UtilisateurItem({required this.nom, required this.role, required this.roleColor});
}

// ── Lot model ─────────────────────────────────────────────────
class Lot {
  final String numero;
  final int quantite;
  final String expiration;
  final String statut;
  final Color statutColor;

  const Lot({
    required this.numero, required this.quantite, required this.expiration,
    required this.statut, required this.statutColor,
  });
}

// ── Historique mouvement ──────────────────────────────────────
class Mouvement {
  final String type;
  final int quantite;
  final String date;
  final bool isEntree;

  const Mouvement({required this.type, required this.quantite, required this.date, required this.isEntree});
}

// ── Rapport item ──────────────────────────────────────────────
class RapportRecent {
  final String nom;
  final String type;
  final String date;

  const RapportRecent({required this.nom, required this.type, required this.date});
}

// ── Temperature chart data ────────────────────────────────────
class TempDataPoint {
  final double heure;
  final double valeur;

  const TempDataPoint(this.heure, this.valeur);
}

// ═════════════════════════════════════════════════════════════
// MOCK DATA
// ═════════════════════════════════════════════════════════════
class MockData {

  // KPIs Dashboard
  static const int nbAlertes       = 3;
  static const int nbStockBas      = 7;
  static const int nbExpirations   = 2;
  static const String capteurs     = '4/4';
  static const double temperature  = 5.2;
  static const double humidite     = 48.0;

  // Inventaire
  static const List<Medicament> medicaments = [
    Medicament(nom:'Amoxicilline 500mg', cip:'3401', categorie:'Antibiotique', zone:'Zone A',
      stock:142, statut:StatutStock.ok, expiration:'08/2027'),
    Medicament(nom:'Insuline Lantus', cip:'5512', categorie:'Endocrino.', zone:'Chambre froide',
      stock:2, statut:StatutStock.rupture, expiration:'09/2026'),
    Medicament(nom:'Paracétamol 1g', cip:'1180', categorie:'Antalgique', zone:'Zone A',
      stock:18, statut:StatutStock.stockBas, expiration:'03/2028'),
    Medicament(nom:'Vaccin BCG', cip:'9043', categorie:'Vaccin', zone:'Chambre froide',
      stock:36, statut:StatutStock.expireBientot, expiration:'25/07/2026', joursExpiration:'J-12'),
    Medicament(nom:'Ibuprofène 400mg', cip:'2207', categorie:'Antalgique', zone:'Zone B',
      stock:210, statut:StatutStock.ok, expiration:'11/2027'),
    Medicament(nom:'Metformine 850mg', cip:'6630', categorie:'Antidiabétique', zone:'Zone B',
      stock:64, statut:StatutStock.ok, expiration:'02/2028'),
    Medicament(nom:'Amoxicilline 1g', cip:'3402', categorie:'Antibiotique', zone:'Zone A',
      stock:85, statut:StatutStock.ok, expiration:'06/2027'),
    Medicament(nom:'Chloroquine 100mg', cip:'4410', categorie:'Antiparasitaire', zone:'Zone A',
      stock:5, statut:StatutStock.stockBas, expiration:'12/2026'),
    Medicament(nom:'Vaccin Hépatite B', cip:'9101', categorie:'Vaccin', zone:'Chambre froide',
      stock:24, statut:StatutStock.ok, expiration:'04/2027'),
    Medicament(nom:'Acide folique 5mg', cip:'1050', categorie:'Vitamines', zone:'Zone B',
      stock:0, statut:StatutStock.rupture, expiration:'08/2027'),
  ];

  // Alertes actives
  static const List<Alerte> alertesActives = [
    Alerte(niveau:NiveauAlerte.critique, type:'Température',
      description:'Hors seuil — 9.1°C (max 8°C)',
      localisation:'Chambre froide', horodatage:'il y a 4 min', peutAccuser:true),
    Alerte(niveau:NiveauAlerte.avertissement, type:'Expiration',
      description:'Vaccin BCG · lot L2402 · J-12',
      localisation:'Chambre froide', horodatage:'il y a 2h', peutAccuser:true),
    Alerte(niveau:NiveauAlerte.stockBas, type:'Réapprovisionnement',
      description:'Paracétamol 1g · 18 u. restantes',
      localisation:'Zone A', horodatage:'il y a 5h', peutAccuser:true),
    Alerte(niveau:NiveauAlerte.systeme, type:'Capteur',
      description:'DHT22 hors ligne 11 min — reconnecté',
      localisation:'Zone B', horodatage:'hier', peutAccuser:false),
  ];

  // Alertes historique
  static const List<Alerte> alertesHistorique = [
    Alerte(niveau:NiveauAlerte.critique, type:'Température',
      description:'Hors seuil — 10.2°C (max 8°C) — Résolu',
      localisation:'Chambre froide', horodatage:'12/07 14h30', peutAccuser:false),
    Alerte(niveau:NiveauAlerte.stockBas, type:'Réapprovisionnement',
      description:'Insuline Lantus · 5 u. restantes — Résolu',
      localisation:'Chambre froide', horodatage:'10/07 09h15', peutAccuser:false),
    Alerte(niveau:NiveauAlerte.avertissement, type:'Expiration',
      description:'Chloroquine lot L2201 · J-28 — Résolu',
      localisation:'Zone A', horodatage:'08/07 11h00', peutAccuser:false),
  ];

  // Seuils capteurs
  static const List<CapteurSeuil> seuils = [
    CapteurSeuil(nom:'DHT22', zone:'Zone A', seuilBas:2, seuilHaut:8, unite:'°C', actif:true),
    CapteurSeuil(nom:'DS18B20', zone:'Chambre froide', seuilBas:2, seuilHaut:8, unite:'°C', actif:true),
    CapteurSeuil(nom:'Température ambiante', zone:'Zone B', seuilBas:15, seuilHaut:25, unite:'°C', actif:true),
    CapteurSeuil(nom:'Humidité', zone:'Zone A', seuilBas:30, seuilHaut:70, unite:'%', actif:true),
  ];

  // Utilisateurs
  static List<UtilisateurItem> utilisateurs = [
    UtilisateurItem(nom:'Fatou Sarr', role:'Pharmacien', roleColor:AppColors.pharmacien),
    UtilisateurItem(nom:'Aïssatou', role:'Personnel', roleColor:AppColors.personnel),
    UtilisateurItem(nom:'Moussa Diop', role:'Technicien', roleColor:AppColors.technicien),
    UtilisateurItem(nom:'Admin', role:'Administrateur', roleColor:AppColors.administrateur),
  ];

  // Lots pour fiche médicament (Insuline Lantus)
  static const List<Lot> lots = [
    Lot(numero:'L2309-A', quantite:2, expiration:'14/09/2026', statut:'Disponible', statutColor:AppColors.statusOk),
    Lot(numero:'L2211-C', quantite:0, expiration:'Expiré', statut:'Isolé', statutColor:AppColors.statusRupture),
  ];

  // Historique mouvements (fiche médicament)
  static const List<Mouvement> historique = [
    Mouvement(type:'Sortie', quantite:6,  date:'8/7/2026',  isEntree:false),
    Mouvement(type:'Entrée', quantite:20, date:'2/7/2026',  isEntree:true),
    Mouvement(type:'Sortie', quantite:4,  date:'28/6/2026', isEntree:false),
    Mouvement(type:'Entrée', quantite:30, date:'15/6/2026', isEntree:true),
  ];

  // Rapports récents
  static const List<RapportRecent> rapportsRecents = [
    RapportRecent(nom:'Rapport_journalier_12-07.pdf', type:'Journalier', date:'12/07/2026 08:00'),
    RapportRecent(nom:'Inventaire_complet_Q2.csv',    type:'Inventaire', date:'30/06/2026 18:22'),
    RapportRecent(nom:'Rapport_temperature_juin.pdf', type:'Température',date:'01/07/2026 07:00'),
  ];

  // Température 24h data (chambre froide zone A)
  static const List<TempDataPoint> tempData24h = [
    TempDataPoint(0,  4.8), TempDataPoint(2,  4.6), TempDataPoint(4,  4.5),
    TempDataPoint(6,  4.7), TempDataPoint(8,  5.1), TempDataPoint(10, 5.8),
    TempDataPoint(12, 6.2), TempDataPoint(14, 9.1), // dépassement
    TempDataPoint(16, 7.8), TempDataPoint(18, 6.4), TempDataPoint(20, 5.9),
    TempDataPoint(22, 5.4), TempDataPoint(24, 5.2),
  ];

  // Humidité 24h data
  static const List<TempDataPoint> humData24h = [
    TempDataPoint(0,  44), TempDataPoint(4,  45), TempDataPoint(8,  47),
    TempDataPoint(12, 50), TempDataPoint(16, 48), TempDataPoint(20, 46), TempDataPoint(24, 46),
  ];

  // Types de rapports
  static const List<Map<String,String>> typesRapports = [
    {'titre':'Inventaire complet',  'sub':'PDF / CSV · à la demande',      'icone':'inventory'},
    {'titre':'Rapport journalier',  'sub':'Auto · 08h00 chaque jour',      'icone':'today'},
    {'titre':'Rapport mensuel',     'sub':'Auto · 1er du mois',            'icone':'calendar_month'},
    {'titre':'Température',         'sub':'PDF · période choisie',         'icone':'thermostat'},
    {'titre':'Ruptures de stock',   'sub':'PDF / CSV · historique',        'icone':'remove_shopping_cart'},
    {'titre':'Audit',               'sub':'PDF · traçabilité complète',    'icone':'fact_check'},
  ];
}

// ── Helper: statut display ────────────────────────────────────
class StatutHelper {
  static String label(StatutStock s, String? j) {
    switch (s) {
      case StatutStock.ok:           return 'OK';
      case StatutStock.rupture:      return 'Rupture';
      case StatutStock.stockBas:     return 'Stock bas';
      case StatutStock.expireBientot: return j ?? 'J-?';
    }
  }

  static Color color(StatutStock s) {
    switch (s) {
      case StatutStock.ok:           return AppColors.statusOk;
      case StatutStock.rupture:      return AppColors.statusRupture;
      case StatutStock.stockBas:     return AppColors.statusStockBas;
      case StatutStock.expireBientot: return AppColors.statusExpire;
    }
  }

  static Color bgColor(StatutStock s) {
    switch (s) {
      case StatutStock.ok:           return AppColors.statusOkBg;
      case StatutStock.rupture:      return AppColors.statusRuptureBg;
      case StatutStock.stockBas:     return AppColors.statusStockBasBg;
      case StatutStock.expireBientot: return AppColors.statusExpireBg;
    }
  }

  static String niveauLabel(NiveauAlerte n) {
    switch (n) {
      case NiveauAlerte.critique:      return 'Critique';
      case NiveauAlerte.avertissement: return 'Avertissement';
      case NiveauAlerte.stockBas:      return 'Stock bas';
      case NiveauAlerte.systeme:       return 'Système';
    }
  }

  static Color niveauColor(NiveauAlerte n) {
    switch (n) {
      case NiveauAlerte.critique:      return AppColors.critique;
      case NiveauAlerte.avertissement: return AppColors.avertissement;
      case NiveauAlerte.stockBas:      return AppColors.stockBas;
      case NiveauAlerte.systeme:       return AppColors.systeme;
    }
  }
}
