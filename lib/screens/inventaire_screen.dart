import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/top_bar.dart';

class InventaireScreen extends StatefulWidget {
  final Function(String route) onNavigate;
  const InventaireScreen({super.key, required this.onNavigate});

  @override
  State<InventaireScreen> createState() => _InventaireScreenState();
}

class _InventaireScreenState extends State<InventaireScreen> {
  int _activeFilter = 0;
  final List<String> _filters = ['Toutes catégories', 'Zone A', 'Rupture', 'Expire bientôt'];

  List<Medicament> get _filtered {
    switch (_activeFilter) {
      case 1: return MockData.medicaments.where((m) => m.zone == 'Zone A').toList();
      case 2: return MockData.medicaments.where((m) => m.statut == StatutStock.rupture).toList();
      case 3: return MockData.medicaments.where((m) => m.statut == StatutStock.expireBientot).toList();
      default: return MockData.medicaments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTopBar(title: 'Inventaire', searchHint: 'Rechercher (nom, code, catégorie)...'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // ── Filtres ──────────────────────────────────────
                Row(
                  children: [
                    ...List.generate(_filters.length, (i) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FilterPill(label: _filters[i], isActive: _activeFilter == i, onTap: () => setState(() => _activeFilter = i)),
                    )),
                    const Spacer(),
                    PrimaryButton(label: 'Scanner un code', icon: Icons.qr_code_scanner),
                  ],
                ),
                const SizedBox(height: 16),

                // ── Table ─────────────────────────────────────────
                Expanded(
                  child: Container(
                    decoration: AppDecorations.card,
                    child: Column(
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.contentBg,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            border: Border(bottom: BorderSide(color: AppColors.divider)),
                          ),
                          child: Row(
                            children: [
                              _hdr('Médicament', 3),
                              _hdr('CIP', 1),
                              _hdr('Catégorie', 2),
                              _hdr('Zone', 2),
                              _hdr('Stock', 1),
                              _hdr('Statut', 2),
                              _hdr('Expiration', 2),
                              const SizedBox(width: 24),
                            ],
                          ),
                        ),
                        // Rows
                        Expanded(
                          child: ListView.separated(
                            itemCount: _filtered.length,
                            separatorBuilder: (_, __) => Divider(height: 1, color: AppColors.divider),
                            itemBuilder: (_, i) => _MedRow(med: _filtered[i], onTap: () => widget.onNavigate('/fiche')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _hdr(String label, int flex) => Expanded(
    flex: flex,
    child: Text(label, style: AppText.tableHdr),
  );
}

class _MedRow extends StatefulWidget {
  final Medicament med;
  final VoidCallback onTap;
  const _MedRow({required this.med, required this.onTap});

  @override
  State<_MedRow> createState() => _MedRowState();
}

class _MedRowState extends State<_MedRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final m = widget.med;
    final statusLabel = StatutHelper.label(m.statut, m.joursExpiration);
    final statusColor = StatutHelper.color(m.statut);
    final statusBg    = StatutHelper.bgColor(m.statut);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          color: _hovered ? AppColors.contentBg : AppColors.cardBg,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(flex: 3, child: Text(m.nom, style: AppText.tableBold)),
              Expanded(flex: 1, child: Text(m.cip, style: AppText.tableCell)),
              Expanded(flex: 2, child: Text(m.categorie, style: AppText.tableCell)),
              Expanded(flex: 2, child: Text(m.zone, style: AppText.tableCell)),
              Expanded(
                flex: 1,
                child: Text(
                  '${m.stock} u.',
                  style: AppText.tableBold.copyWith(
                    color: m.statut == StatutStock.rupture ? AppColors.statusRupture
                         : m.statut == StatutStock.stockBas ? AppColors.statusStockBas
                         : AppColors.textPrimary,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: StatusBadge(label: statusLabel, color: statusColor, bgColor: statusBg),
              ),
              Expanded(flex: 2, child: Text(m.expiration, style: AppText.tableCell)),
              const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
