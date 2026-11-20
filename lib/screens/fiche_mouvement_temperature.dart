import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/top_bar.dart';

// ═══════════════════════════════════════════════════════════════
// FICHE MÉDICAMENT
// ═══════════════════════════════════════════════════════════════
class FicheMedicamentScreen extends StatelessWidget {
  final Function(String) onNavigate;
  const FicheMedicamentScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppTopBar(title: 'Fiche médicament'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ───────────────────────────────────────
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Insuline Lantus', style: AppText.pageTitle),
                        const SizedBox(height: 4),
                        Text('CIP 5512  ·  Vaccins/Insuline  ·  Chambre froide',
                          style: AppText.tableCell.copyWith(color: AppColors.textMuted)),
                      ],
                    ),
                    const Spacer(),
                    PrimaryButton(label: '+ Nouveau mouvement', onTap: () => onNavigate('/mouvement')),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Conditions stockage ───────────────────────
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: AppDecorations.card,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Conditions de stockage', style: AppText.sectionTitle),
                                const Spacer(),
                                StatusBadge(label: 'Conforme', color: AppColors.statusOk, bgColor: AppColors.statusOkBg),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _condRow('Température actuelle', '4.8°C'),
                            _condRow('Seuil recommandé',     '2 – 8°C'),
                            _condRow('Humidité actuelle',    '46%'),
                            _condRow('Humidité max',         '50%'),
                            _condRow('Zone de stockage',     'A-12  ·  Chambre froide'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // ── Lots + historique ─────────────────────────
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          // Lots
                          Container(
                            decoration: AppDecorations.card,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.contentBg,
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                    border: Border(bottom: BorderSide(color: AppColors.divider)),
                                  ),
                                  child: Row(children: [
                                    Expanded(flex:2, child: Text('Lot', style: AppText.tableHdr)),
                                    Expanded(flex:1, child: Text('Quantité', style: AppText.tableHdr)),
                                    Expanded(flex:2, child: Text('Expiration', style: AppText.tableHdr)),
                                    Expanded(flex:2, child: Text('Statut', style: AppText.tableHdr)),
                                  ]),
                                ),
                                ...MockData.lots.map((lot) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  child: Row(children: [
                                    Expanded(flex:2, child: Text(lot.numero, style: AppText.tableBold)),
                                    Expanded(flex:1, child: Text('${lot.quantite} u.', style: AppText.tableCell)),
                                    Expanded(flex:2, child: Text(lot.expiration, style: AppText.tableCell)),
                                    Expanded(flex:2, child: StatusBadge(label: lot.statut, color: lot.statutColor, bgColor: lot.statutColor.withOpacity(0.12))),
                                  ]),
                                )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Historique
                          Container(
                            decoration: AppDecorations.card,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.contentBg,
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                    border: Border(bottom: BorderSide(color: AppColors.divider)),
                                  ),
                                  child: Row(children: [
                                    Expanded(flex:2, child: Text('Historique', style: AppText.tableHdr)),
                                    Expanded(flex:1, child: Text('Quantité', style: AppText.tableHdr)),
                                    Expanded(flex:2, child: Text('Date', style: AppText.tableHdr)),
                                  ]),
                                ),
                                ...MockData.historique.map((mv) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  child: Row(children: [
                                    Expanded(flex:2, child: Row(children: [
                                      Icon(mv.isEntree ? Icons.arrow_upward : Icons.arrow_downward,
                                        size: 14, color: mv.isEntree ? AppColors.statusOk : AppColors.statusRupture),
                                      const SizedBox(width: 6),
                                      Text(mv.type, style: AppText.tableCell),
                                    ])),
                                    Expanded(flex:1, child: Text('${mv.quantite} u.', style: AppText.tableBold)),
                                    Expanded(flex:2, child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(color: AppColors.contentBg, borderRadius: BorderRadius.circular(6)),
                                      child: Text(mv.date, style: AppText.tableCell.copyWith(fontSize: 12)),
                                    )),
                                  ]),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _condRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Text(label, style: AppText.tableCell.copyWith(color: AppColors.textSecondary)),
        const Spacer(),
        Text(value, style: AppText.tableBold),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// MOUVEMENT DE STOCK
// ═══════════════════════════════════════════════════════════════
class MouvementStockScreen extends StatefulWidget {
  const MouvementStockScreen({super.key});

  @override
  State<MouvementStockScreen> createState() => _MouvementStockScreenState();
}

class _MouvementStockScreenState extends State<MouvementStockScreen> {
  bool _isEntree = false;
  int _quantite = 12;
  int _motifIndex = 0;
  final List<String> _motifs = ['Dispensation', 'Perte', 'Retour fournisseur'];

  @override
  Widget build(BuildContext context) {
    final bool showWarning = !_isEntree && _quantite >= 4;

    return Column(
      children: [
        const AppTopBar(title: 'Mouvement de stock'),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Container(
                width: 560,
                padding: const EdgeInsets.all(28),
                decoration: AppDecorations.card,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nouveau mouvement — Insuline Lantus', style: AppText.tableCell.copyWith(color: AppColors.textMuted, fontSize: 13)),
                    const SizedBox(height: 20),

                    // Toggle Entrée / Sortie
                    Row(
                      children: [
                        Expanded(child: _ToggleBtn(label: 'Entrée', isActive: _isEntree,  onTap: () => setState(() => _isEntree = true))),
                        const SizedBox(width: 12),
                        Expanded(child: _ToggleBtn(label: 'Sortie', isActive: !_isEntree, onTap: () => setState(() => _isEntree = false), isOutline: true)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Lot
                    Text('Lot concerné', style: AppText.tableHdr.copyWith(color: AppColors.textSecondary, fontSize: 12)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg, borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primary, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          Text('Lot L2309-A  ·  exp. 14/09/2026', style: AppText.tableBold),
                          const Spacer(),
                          const Icon(Icons.expand_more, color: AppColors.textMuted),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Quantité stepper
                    Text('Quantité', style: AppText.tableHdr.copyWith(color: AppColors.textSecondary, fontSize: 12)),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.cardBg, borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primary, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          _StepperBtn(icon: Icons.remove, onTap: () => setState(() { if (_quantite > 1) _quantite--; })),
                          Expanded(child: Center(child: Text('$_quantite', style: AppText.tableBold.copyWith(fontSize: 18)))),
                          _StepperBtn(icon: Icons.add,    onTap: () => setState(() => _quantite++)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Motif chips
                    Text('Motif', style: AppText.tableHdr.copyWith(color: AppColors.textSecondary, fontSize: 12)),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(_motifs.length, (i) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () => setState(() => _motifIndex = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: _motifIndex == i ? AppColors.primary : AppColors.cardBg,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: _motifIndex == i ? AppColors.primary : AppColors.divider, width: 1.5),
                            ),
                            child: Text(_motifs[i], style: AppText.tableCell.copyWith(
                              color: _motifIndex == i ? Colors.white : AppColors.textSecondary,
                              fontWeight: _motifIndex == i ? FontWeight.w600 : FontWeight.w400,
                            )),
                          ),
                        ),
                      )),
                    ),

                    // Warning
                    if (showWarning) ...[
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.avertissement.withOpacity(0.3))),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber, color: AppColors.avertissement, size: 20),
                            const SizedBox(width: 10),
                            Expanded(child: Text('Quantité ≤ seuil de réappro (10 u.) après validation.',
                              style: AppText.tableCell.copyWith(color: AppColors.avertissement))),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 28),

                    // Valider
                    SizedBox(
                      width: double.infinity, height: 52,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
                        child: Text('Valider le mouvement', style: AppText.navItem.copyWith(fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ToggleBtn extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isOutline;
  final VoidCallback onTap;

  const _ToggleBtn({required this.label, required this.isActive, required this.onTap, this.isOutline = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.cardBg,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: isActive ? AppColors.primary : AppColors.divider, width: 1.5),
        ),
        child: Center(child: Text(label, style: AppText.tableBold.copyWith(
          color: isActive ? Colors.white : AppColors.primary, fontSize: 14))),
      ),
    );
  }
}

class _StepperBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _StepperBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48, height: 52,
        decoration: BoxDecoration(color: AppColors.contentBg, borderRadius: BorderRadius.circular(9)),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SURVEILLANCE TEMPÉRATURE
// ═══════════════════════════════════════════════════════════════
class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({super.key});

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  int _period = 0;
  final List<String> _periods = ['24h', '7 jours', '30 jours'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppTopBar(title: 'Surveillance température'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Filtres période
                Row(
                  children: [
                    ...List.generate(_periods.length, (i) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FilterPill(label: _periods[i], isActive: _period == i, onTap: () => setState(() => _period = i)),
                    )),
                    const Spacer(),
                    OutlineBtn(label: 'Export CSV', icon: Icons.download_outlined),
                  ],
                ),
                const SizedBox(height: 20),

                // Graphique température
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppDecorations.card,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Température — Chambre froide, Zone A', style: AppText.sectionTitle),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: AppColors.statusRuptureBg, borderRadius: BorderRadius.circular(6)),
                            child: Text('1 dépassement', style: AppText.tableCell.copyWith(color: AppColors.critique, fontWeight: FontWeight.w700, fontSize: 12)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 240,
                        child: LineChart(_buildTempChart()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Graphique humidité
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: AppDecorations.card,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Humidité (%)', style: AppText.sectionTitle),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: LineChart(_buildHumChart()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  LineChartData _buildTempChart() {
    final spots = MockData.tempData24h.map((d) => FlSpot(d.heure, d.valeur)).toList();
    return LineChartData(
      minY: 0, maxY: 12,
      clipData: FlClipData.all(),
      gridData: FlGridData(
        show: true, drawVerticalLine: false, horizontalInterval: 2,
        getDrawingHorizontalLine: (_) => FlLine(color: AppColors.divider, strokeWidth: 1),
      ),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(
          showTitles: true, reservedSize: 36, interval: 2,
          getTitlesWidget: (v, _) => Text('${v.toInt()}°C', style: AppText.bodySmall.copyWith(fontSize: 10)),
        )),
        bottomTitles: AxisTitles(sideTitles: SideTitles(
          showTitles: true, reservedSize: 24, interval: 6,
          getTitlesWidget: (v, _) {
            final h = v.toInt();
            final labels = {0:'00:00', 6:'06:00', 12:'12:00', 18:'18:00', 24:'23:59'};
            return Text(labels[h] ?? '', style: AppText.bodySmall.copyWith(fontSize: 10));
          },
        )),
        topTitles:   const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      extraLinesData: ExtraLinesData(horizontalLines: [
        HorizontalLine(y: 8, color: AppColors.critique, strokeWidth: 1.5, dashArray: [6, 4]),
        HorizontalLine(y: 2, color: AppColors.critique, strokeWidth: 1.5, dashArray: [6, 4]),
      ]),
      betweenBarsData: [
        BetweenBarsData(fromIndex: 0, toIndex: 0,
          color: AppColors.critique.withOpacity(0.08)),
      ],
      lineBarsData: [
        LineChartBarData(
          spots: spots, isCurved: true, color: AppColors.chartGreen, barWidth: 2.5,
          dotData: FlDotData(
            show: true,
            checkToShowDot: (s, _) => s.y > 8,
            getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(radius: 5, color: AppColors.critique, strokeWidth: 2, strokeColor: Colors.white),
          ),
          belowBarData: BarAreaData(
            show: true, color: AppColors.chartGreen.withOpacity(0.08),
            cutOffY: 8, applyCutOffY: true,
          ),
          aboveBarData: BarAreaData(
            show: true, color: AppColors.critique.withOpacity(0.12),
            cutOffY: 8, applyCutOffY: true,
          ),
        ),
      ],
    );
  }

  LineChartData _buildHumChart() {
    final spots = MockData.humData24h.map((d) => FlSpot(d.heure, d.valeur)).toList();
    return LineChartData(
      minY: 30, maxY: 70,
      gridData: FlGridData(
        show: true, drawVerticalLine: false, horizontalInterval: 10,
        getDrawingHorizontalLine: (_) => FlLine(color: AppColors.divider, strokeWidth: 1),
      ),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(
          showTitles: true, reservedSize: 36, interval: 10,
          getTitlesWidget: (v, _) => Text('${v.toInt()}%', style: AppText.bodySmall.copyWith(fontSize: 10)),
        )),
        bottomTitles: AxisTitles(sideTitles: SideTitles(
          showTitles: true, reservedSize: 24, interval: 6,
          getTitlesWidget: (v, _) {
            final h = v.toInt();
            final labels = {0:'00:00', 6:'06:00', 12:'12:00', 18:'18:00', 24:'23:59'};
            return Text(labels[h] ?? '', style: AppText.bodySmall.copyWith(fontSize: 10));
          },
        )),
        topTitles:   const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots, isCurved: true, color: AppColors.chartGreen, barWidth: 2.5,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: true, color: AppColors.chartGreen.withOpacity(0.08)),
        ),
      ],
    );
  }
}
