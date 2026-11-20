import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/top_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppTopBar(title: 'Tableau de bord', searchHint: 'Rechercher...'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── KPI Row ──────────────────────────────────────
                Row(
                  children: [
                    Expanded(child: KpiCard(value: '${MockData.nbAlertes}',     label: 'Alertes',            valueColor: AppColors.kpiAlertes)),
                    const SizedBox(width: 16),
                    Expanded(child: KpiCard(value: '${MockData.nbStockBas}',    label: 'Stock bas',          valueColor: AppColors.kpiStockBas)),
                    const SizedBox(width: 16),
                    Expanded(child: KpiCard(value: '${MockData.nbExpirations}', label: 'Expirations < 30j',  valueColor: AppColors.kpiExpirations)),
                    const SizedBox(width: 16),
                    Expanded(child: KpiCard(value: MockData.capteurs,           label: 'Capteurs connectés', valueColor: AppColors.kpiCapteurs)),
                  ],
                ),
                const SizedBox(height: 20),

                // ── Charts Row ───────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Donut chart
                    Expanded(
                      flex: 4,
                      child: _DonutCard(),
                    ),
                    const SizedBox(width: 16),
                    // Line chart
                    Expanded(
                      flex: 6,
                      child: _LineChartCard(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ── Accès rapide ─────────────────────────────────
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Accès rapide', style: AppText.sectionTitle),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _AccessPill(label: 'Stock bas',           value: '7 articles', bgColor: const Color(0xFFE65100), valueBg: const Color(0xFFFF8F00)),
                        const SizedBox(width: 12),
                        _AccessPill(label: 'Expirations',          value: '2 lots',     bgColor: AppColors.primary,       valueBg: AppColors.statusOk),
                        const SizedBox(width: 12),
                        _AccessPill(label: 'Alertes température',  value: '1 critique', bgColor: AppColors.primary,       valueBg: AppColors.critique),
                      ],
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
}

// ── Donut chart card ──────────────────────────────────────────
class _DonutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppDecorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Chambre froide — Zone A', style: AppText.sectionTitle),
          Text('${MockData.temperature}°C', style: AppText.kpiValue(AppColors.statusOk).copyWith(fontSize: 22)),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 52,
                    sections: [
                      PieChartSectionData(value: 72, color: AppColors.chartGreen,      radius: 30, showTitle: false),
                      PieChartSectionData(value: 28, color: AppColors.chartGreenLight, radius: 30, showTitle: false),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${MockData.temperature}°C', style: AppText.kpiValue(AppColors.statusOk).copyWith(fontSize: 18)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _LegendItem(color: AppColors.chartGreen, label: 'Normale'),
              const SizedBox(width: 16),
              _LegendItem(color: Colors.blue[300]!, label: '${MockData.humidite.toInt()}%', icon: Icons.water_drop_outlined),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final IconData? icon;

  const _LegendItem({required this.color, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: AppColors.contentBg, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Icon(icon, color: color, size: 14)
              : Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(label, style: AppText.tableCell.copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// ── Line chart card ───────────────────────────────────────────
class _LineChartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spots = MockData.tempData24h.map((d) => FlSpot(d.heure, d.valeur)).toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppDecorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Température (Zone A)', style: AppText.sectionTitle),
                  Text('Dernières 24h', style: AppText.tableCell.copyWith(color: AppColors.textMuted, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minY: 0, maxY: 12,
                clipData: FlClipData.all(),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 2,
                  getDrawingHorizontalLine: (_) => FlLine(color: AppColors.divider, strokeWidth: 1),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(
                    showTitles: true, reservedSize: 32, interval: 2,
                    getTitlesWidget: (v, m) => Text('${v.toInt()}°C', style: AppText.bodySmall.copyWith(fontSize: 10)),
                  )),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(
                    showTitles: true, reservedSize: 24, interval: 6,
                    getTitlesWidget: (v, m) {
                      final h = v.toInt();
                      return Text(h == 0 ? '00:00' : h == 6 ? '06:00' : h == 12 ? '12:00' : h == 18 ? '18:00' : h == 24 ? '24:00' : '',
                        style: AppText.bodySmall.copyWith(fontSize: 10));
                    },
                  )),
                  topTitles:   const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                // Seuil max (rouge pointillé)
                extraLinesData: ExtraLinesData(horizontalLines: [
                  HorizontalLine(y: 8, color: AppColors.critique, strokeWidth: 1.5, dashArray: [6, 4],
                    label: HorizontalLineLabel(show: false)),
                  HorizontalLine(y: 2, color: AppColors.critique, strokeWidth: 1.5, dashArray: [6, 4]),
                ]),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppColors.chartBlue,
                    barWidth: 2.5,
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (spot, _) => spot.y > 8,
                      getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(radius: 5, color: AppColors.critique, strokeWidth: 2, strokeColor: Colors.white),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.chartBlue.withOpacity(0.08),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Access pill ───────────────────────────────────────────────
class _AccessPill extends StatelessWidget {
  final String label;
  final String value;
  final Color bgColor;
  final Color valueBg;

  const _AccessPill({required this.label, required this.value, required this.bgColor, required this.valueBg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(label, style: AppText.navItem.copyWith(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: valueBg, borderRadius: BorderRadius.circular(20)),
            child: Text(value, style: AppText.navItem.copyWith(fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
