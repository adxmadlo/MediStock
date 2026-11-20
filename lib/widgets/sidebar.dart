import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppSidebar extends StatelessWidget {
  final String currentRoute;
  final Function(String) onNavigate;

  const AppSidebar({super.key, required this.currentRoute, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: AppDecorations.sidebar,
      child: Column(
        children: [
          // ── Logo ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.favorite, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MediStock', style: AppText.navItemActive.copyWith(fontSize: 15, letterSpacing: 0.3)),
                    Text('IoT PLATFORM', style: AppText.sidebarLabel),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Color(0x33FFFFFF), height: 1),
          const SizedBox(height: 12),

          // ── Navigation ────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel('Vue d\'ensemble'),
                  _navItem(Icons.home_outlined, Icons.home, 'Tableau de bord', '/dashboard'),
                  const SizedBox(height: 8),

                  _sectionLabel('Stock'),
                  _navItem(Icons.inventory_2_outlined, Icons.inventory_2, 'Inventaire', '/inventaire'),
                  _navItem(Icons.description_outlined, Icons.description, 'Fiche médicament', '/fiche'),
                  _navItem(Icons.add_circle_outline, Icons.add_circle, 'Mouvement stock', '/mouvement'),
                  const SizedBox(height: 8),

                  _sectionLabel('Surveillance'),
                  _navItem(Icons.show_chart, Icons.show_chart, 'Température', '/temperature'),
                  _navItem(Icons.warning_amber_outlined, Icons.warning_amber, 'Alertes', '/alertes'),
                  const SizedBox(height: 8),

                  _sectionLabel('Gestion'),
                  _navItem(Icons.article_outlined, Icons.article, 'Rapports', '/rapports'),
                  _navItem(Icons.settings_outlined, Icons.settings, 'Paramètres', '/parametres'),
                  _navItem(Icons.person_outline, Icons.person, 'Profil', '/profil'),
                ],
              ),
            ),
          ),

          // ── User card ─────────────────────────────────────────
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(18)),
                  child: const Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fatou Sarr', style: AppText.navItem.copyWith(fontSize: 13, fontWeight: FontWeight.w600)),
                    Text('Pharmacien', style: AppText.sidebarLabel.copyWith(fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String label) => Padding(
    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
    child: Text(label.toUpperCase(), style: AppText.sidebarLabel),
  );

  Widget _navItem(IconData iconOutlined, IconData iconFilled, String label, String route) {
    final bool isActive = currentRoute == route;
    return GestureDetector(
      onTap: () => onNavigate(route),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.18) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(isActive ? iconFilled : iconOutlined, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Text(label, style: isActive ? AppText.navItemActive : AppText.navItem),
          ],
        ),
      ),
    );
  }
}
