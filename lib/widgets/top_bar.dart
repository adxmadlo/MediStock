import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ── TopBar ────────────────────────────────────────────────────
class AppTopBar extends StatelessWidget {
  final String title;
  final String searchHint;

  const AppTopBar({super.key, required this.title, this.searchHint = 'Rechercher...'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: AppDecorations.topBar,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        children: [
          Text(title, style: AppText.pageTitle),
          const Spacer(),
          // Search
          Container(
            width: 280, height: 38,
            decoration: BoxDecoration(
              color: AppColors.contentBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                const Icon(Icons.search, color: AppColors.textMuted, size: 18),
                const SizedBox(width: 8),
                Expanded(child: Text(searchHint, style: AppText.tableCell.copyWith(color: AppColors.textMuted, fontSize: 13))),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Bell
          Stack(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(color: AppColors.contentBg, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.notifications_outlined, color: AppColors.textSecondary, size: 20),
              ),
              Positioned(
                top: 6, right: 6,
                child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.critique, shape: BoxShape.circle)),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Avatar
          Row(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(color: AppColors.contentBg, borderRadius: BorderRadius.circular(19)),
                child: const Icon(Icons.person, color: AppColors.textSecondary, size: 20),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fatou Sarr', style: AppText.tableBold.copyWith(fontSize: 12)),
                  Text('Pharmacien', style: AppText.tableCell.copyWith(fontSize: 11, color: AppColors.textMuted)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── StatusBadge ───────────────────────────────────────────────
class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color bgColor;
  final bool bold;

  const StatusBadge({super.key, required this.label, required this.color, required this.bgColor, this.bold = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: AppText.tableCell.copyWith(color: color, fontWeight: bold ? FontWeight.w700 : FontWeight.w500, fontSize: 12)),
    );
  }
}

// ── KpiCard ───────────────────────────────────────────────────
class KpiCard extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const KpiCard({super.key, required this.value, required this.label, required this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: AppDecorations.card,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: AppText.kpiValue(valueColor)),
          const SizedBox(height: 4),
          Text(label, style: AppText.kpiLabel, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// ── SectionCard ───────────────────────────────────────────────
class SectionCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final EdgeInsets? padding;
  final Widget? trailing;

  const SectionCard({super.key, this.title, required this.child, this.padding, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
              child: Row(
                children: [
                  Text(title!, style: AppText.sectionTitle),
                  const Spacer(),
                  if (trailing != null) trailing!,
                ],
              ),
            ),
          Padding(
            padding: padding ?? const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }
}

// ── FilterPill ────────────────────────────────────────────────
class FilterPill extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const FilterPill({super.key, required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isActive ? AppColors.primary : AppColors.divider, width: 1.5),
        ),
        child: Text(
          label,
          style: AppText.tableCell.copyWith(
            color: isActive ? AppColors.white : AppColors.textSecondary,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ── TableHeaderRow ────────────────────────────────────────────
class TableHeaderRow extends StatelessWidget {
  final List<String> columns;
  final List<double> flexes;

  const TableHeaderRow({super.key, required this.columns, required this.flexes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.contentBg,
        border: Border(bottom: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: Row(
        children: List.generate(columns.length, (i) => Expanded(
          flex: (flexes[i] * 10).round(),
          child: Text(columns[i], style: AppText.tableHdr),
        )),
      ),
    );
  }
}

// ── PrimaryButton ─────────────────────────────────────────────
class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool small;

  const PrimaryButton({super.key, required this.label, this.icon, this.onTap, this.small = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: small ? 14 : 20, vertical: small ? 8 : 12),
        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, color: AppColors.white, size: 16), const SizedBox(width: 6)],
            Text(label, style: AppText.navItem.copyWith(fontSize: small ? 12 : 13, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

// ── OutlineButton custom ──────────────────────────────────────
class OutlineBtn extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;

  const OutlineBtn({super.key, required this.label, this.icon, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(color: AppColors.cardBg, borderRadius: BorderRadius.circular(8), border: Border.all(color: c, width: 1.5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, color: c, size: 15), const SizedBox(width: 6)],
            Text(label, style: AppText.tableCell.copyWith(color: c, fontWeight: FontWeight.w600, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// ── Main layout scaffold ──────────────────────────────────────
class AppScaffold extends StatefulWidget {
  final Widget screen;
  final String initialRoute;

  const AppScaffold({super.key, required this.screen, required this.initialRoute});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  late String _route;
  late Widget _screen;

  @override
  void initState() {
    super.initState();
    _route = widget.initialRoute;
    _screen = widget.screen;
  }

  void _navigate(String route) {
    setState(() {
      _route = route;
      _screen = _routeToScreen(route);
    });
  }

  Widget _routeToScreen(String route) {
    // Import all screens dynamically
    // This will be resolved by the main app router
    return _RouteResolver(route: route);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppSidebar(currentRoute: _route, onNavigate: _navigate),
        Expanded(child: _screen),
      ],
    );
  }
}

// Placeholder resolved in main.dart
class _RouteResolver extends StatelessWidget {
  final String route;
  const _RouteResolver({required this.route});

  @override
  Widget build(BuildContext context) => Center(child: Text('Route: $route'));
}
