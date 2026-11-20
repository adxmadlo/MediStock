import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/top_bar.dart';

// ═══════════════════════════════════════════════════════════════
// ALERTES
// ═══════════════════════════════════════════════════════════════
class AlertesScreen extends StatefulWidget {
  const AlertesScreen({super.key});

  @override
  State<AlertesScreen> createState() => _AlertesScreenState();
}

class _AlertesScreenState extends State<AlertesScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final alertes = _tab == 0 ? MockData.alertesActives : MockData.alertesHistorique;

    return Column(
      children: [
        const AppTopBar(title: 'Alertes', searchHint: 'Rechercher...'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tabs
                Row(
                  children: [
                    _Tab(label: 'Actives (${MockData.alertesActives.length})', isActive: _tab == 0, onTap: () => setState(() => _tab = 0)),
                    const SizedBox(width: 8),
                    _Tab(label: 'Historique', isActive: _tab == 1, onTap: () => setState(() => _tab = 1)),
                  ],
                ),
                const SizedBox(height: 20),

                // Table
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
                          child: Row(children: [
                            _h('Sévérité',    2),
                            _h('Type',        2),
                            _h('Description', 4),
                            _h('Localisation',2),
                            _h('Horodatage',  2),
                            _h('Actions',     2),
                          ]),
                        ),
                        // Rows
                        Expanded(
                          child: ListView.separated(
                            itemCount: alertes.length,
                            separatorBuilder: (_, __) => Divider(height: 1, color: AppColors.divider),
                            itemBuilder: (_, i) => _AlerteRow(alerte: alertes[i]),
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

  Widget _h(String label, int flex) => Expanded(flex: flex, child: Text(label, style: AppText.tableHdr));
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _Tab({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isActive ? AppColors.primary : AppColors.divider, width: 1.5),
        ),
        child: Text(label, style: AppText.tableCell.copyWith(
          color: isActive ? Colors.white : AppColors.textSecondary,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
        )),
      ),
    );
  }
}

class _AlerteRow extends StatelessWidget {
  final Alerte alerte;
  const _AlerteRow({required this.alerte});

  @override
  Widget build(BuildContext context) {
    final col  = StatutHelper.niveauColor(alerte.niveau);
    final label = StatutHelper.niveauLabel(alerte.niveau);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(flex:2, child: Text(label, style: AppText.tableBold.copyWith(color: col, fontSize: 13))),
          Expanded(flex:2, child: Text(alerte.type, style: AppText.tableCell)),
          Expanded(flex:4, child: Text(alerte.description, style: AppText.tableCell)),
          Expanded(flex:2, child: Text(alerte.localisation, style: AppText.tableCell)),
          Expanded(flex:2, child: Text(alerte.horodatage,   style: AppText.tableCell.copyWith(color: AppColors.textMuted))),
          Expanded(
            flex: 2,
            child: alerte.peutAccuser
                ? OutlineBtn(label: 'Accuser réception', color: col)
                : Text('—', style: AppText.tableCell.copyWith(color: AppColors.textMuted)),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// RAPPORTS
// ═══════════════════════════════════════════════════════════════
class RapportsScreen extends StatelessWidget {
  const RapportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppTopBar(title: 'Rapports', searchHint: 'Rechercher...'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Rapports disponibles', style: AppText.sectionTitle),
                    const Spacer(),
                    PrimaryButton(label: '+ Générer un rapport', icon: Icons.add),
                  ],
                ),
                const SizedBox(height: 20),

                // Grid rapports
                GridView.count(
                  crossAxisCount: 3, shrinkWrap: true,
                  mainAxisSpacing: 16, crossAxisSpacing: 16,
                  childAspectRatio: 2.2,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _RapportCard(titre:'Inventaire complet',   sub:'PDF / CSV  ·  à la demande',     icon:Icons.inventory_2_outlined),
                    _RapportCard(titre:'Rapport journalier',   sub:'Auto  ·  08h00 chaque jour',     icon:Icons.today_outlined),
                    _RapportCard(titre:'Rapport mensuel',      sub:'Auto  ·  1er du mois',           icon:Icons.calendar_month_outlined),
                    _RapportCard(titre:'Température',          sub:'PDF  ·  période choisie',        icon:Icons.show_chart),
                    _RapportCard(titre:'Ruptures de stock',    sub:'PDF / CSV  ·  historique',       icon:Icons.remove_shopping_cart_outlined),
                    _RapportCard(titre:'Audit',                sub:'PDF  ·  traçabilité complète',   icon:Icons.fact_check_outlined),
                  ],
                ),
                const SizedBox(height: 24),

                // Rapports récents
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
                          Expanded(flex:4, child: Text('Rapport récent', style: AppText.tableHdr)),
                          Expanded(flex:2, child: Text('Type',           style: AppText.tableHdr)),
                          Expanded(flex:3, child: Text('Généré le',      style: AppText.tableHdr)),
                          Expanded(flex:1, child: Text('',               style: AppText.tableHdr)),
                        ]),
                      ),
                      ...MockData.rapportsRecents.map((r) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(children: [
                          Expanded(flex:4, child: Text(r.nom,  style: AppText.tableBold.copyWith(fontSize: 13))),
                          Expanded(flex:2, child: Text(r.type, style: AppText.tableCell)),
                          Expanded(flex:3, child: Text(r.date, style: AppText.tableCell)),
                          Expanded(flex:1, child: Text('Reçu', style: AppText.tableBold.copyWith(color: AppColors.statusOk))),
                        ]),
                      )),
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
}

class _RapportCard extends StatefulWidget {
  final String titre, sub;
  final IconData icon;
  const _RapportCard({required this.titre, required this.sub, required this.icon});

  @override
  State<_RapportCard> createState() => _RapportCardState();
}

class _RapportCardState extends State<_RapportCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.contentBg : AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _hovered ? AppColors.primary.withOpacity(0.4) : AppColors.divider),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: _hovered ? AppColors.primary : AppColors.textMuted, size: 24),
            const SizedBox(height: 8),
            Text(widget.titre, style: AppText.tableBold.copyWith(fontSize: 13), textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text(widget.sub, style: AppText.tableCell.copyWith(fontSize: 11, color: AppColors.textMuted), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// PARAMÈTRES
// ═══════════════════════════════════════════════════════════════
class ParametresScreen extends StatefulWidget {
  const ParametresScreen({super.key});

  @override
  State<ParametresScreen> createState() => _ParametresScreenState();
}

class _ParametresScreenState extends State<ParametresScreen> {
  final List<CapteurSeuil> _seuils = List.from(MockData.seuils);
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppTopBar(title: 'Paramètres', searchHint: 'Rechercher...'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Seuils d'alerte ───────────────────────────────
                Expanded(
                  child: Container(
                    decoration: AppDecorations.card,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Text('Seuils d\'alerte', style: AppText.sectionTitle),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 8),
                          child: Text('(modifiable)', style: AppText.tableCell.copyWith(color: AppColors.textMuted, fontSize: 12)),
                        ),
                        // Header
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.contentBg,
                            border: Border.symmetric(horizontal: BorderSide(color: AppColors.divider)),
                          ),
                          child: Row(children: [
                            Expanded(flex:3, child: Text('Capteur',    style: AppText.tableHdr)),
                            Expanded(flex:2, child: Text('Zone',       style: AppText.tableHdr)),
                            Expanded(flex:1, child: Text('Seuil bas',  style: AppText.tableHdr)),
                            Expanded(flex:1, child: Text('Seuil haut', style: AppText.tableHdr)),
                            Expanded(flex:1, child: Text('Unité',      style: AppText.tableHdr)),
                            Expanded(flex:1, child: Text('Statut',     style: AppText.tableHdr)),
                          ]),
                        ),
                        // Rows
                        ..._seuils.asMap().entries.map((e) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(children: [
                                Expanded(flex:3, child: Text(e.value.nom,  style: AppText.tableBold)),
                                Expanded(flex:2, child: Text(e.value.zone, style: AppText.tableCell)),
                                Expanded(flex:1, child: Text('${e.value.seuilBas.toInt()}',  style: AppText.tableCell)),
                                Expanded(flex:1, child: Text('${e.value.seuilHaut.toInt()}', style: AppText.tableCell)),
                                Expanded(flex:1, child: Text(e.value.unite, style: AppText.tableCell)),
                                Expanded(flex:1, child: StatusBadge(
                                  label: e.value.actif ? 'Actif' : 'Inactif',
                                  color: e.value.actif ? AppColors.statusOk : AppColors.statusRupture,
                                  bgColor: e.value.actif ? AppColors.statusOkBg : AppColors.statusRuptureBg,
                                )),
                              ]),
                            ),
                            if (e.key < _seuils.length - 1) Divider(height: 1, color: AppColors.divider),
                          ],
                        )),
                        // Save button
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () => setState(() => _saved = true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                            child: Text(_saved ? '✓ Modifications enregistrées' : 'Enregistrer les modifications',
                              style: AppText.navItem.copyWith(fontSize: 13, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                // ── Gestion utilisateurs ──────────────────────────
                Expanded(
                  child: Container(
                    decoration: AppDecorations.card,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                          child: Text('Gestion des utilisateurs', style: AppText.sectionTitle),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.contentBg,
                            border: Border.symmetric(horizontal: BorderSide(color: AppColors.divider)),
                          ),
                          child: Row(children: [
                            Expanded(flex:3, child: Text('Utilisateur', style: AppText.tableHdr)),
                            Expanded(flex:2, child: Text('Rôle',        style: AppText.tableHdr)),
                            Expanded(flex:1, child: Text('Actions',     style: AppText.tableHdr)),
                          ]),
                        ),
                        ...MockData.utilisateurs.asMap().entries.map((e) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              child: Row(children: [
                                Expanded(flex:3, child: Text(e.value.nom, style: AppText.tableBold)),
                                Expanded(flex:2, child: Text(e.value.role, style: AppText.tableBold.copyWith(color: e.value.roleColor))),
                                Expanded(flex:1, child: const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 18)),
                              ]),
                            ),
                            if (e.key < MockData.utilisateurs.length - 1) Divider(height: 1, color: AppColors.divider),
                          ],
                        )),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: OutlineBtn(label: '+ Ajouter un utilisateur'),
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
}

// ═══════════════════════════════════════════════════════════════
// PROFIL
// ═══════════════════════════════════════════════════════════════
class ProfilScreen extends StatefulWidget {
  final Function(String) onLogout;
  const ProfilScreen({super.key, required this.onLogout});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  bool _alertesTemp   = true;
  bool _rapportQuotidien = true;
  bool _smsUrgents    = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppTopBar(title: 'Profil'),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: 600,
                child: Column(
                  children: [
                    // Carte profil
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: AppDecorations.card,
                      child: Row(
                        children: [
                          Container(
                            width: 52, height: 52,
                            decoration: BoxDecoration(color: AppColors.contentBg, borderRadius: BorderRadius.circular(26)),
                            child: const Icon(Icons.person, color: AppColors.textSecondary, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Fatou Sarr', style: AppText.sectionTitle),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: AppColors.statusOkBg, borderRadius: BorderRadius.circular(6)),
                                child: Text('Pharmacien — Responsable stock',
                                  style: AppText.tableCell.copyWith(color: AppColors.statusOk, fontWeight: FontWeight.w600, fontSize: 13)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Compte
                    _InfoSection(
                      title: 'Compte',
                      rows: const [
                        ['Email',     'f.sarr@medistock.sn'],
                        ['Pharmacie', 'Centrale — Dakar'],
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Notifications
                    Container(
                      decoration: AppDecorations.card,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                            child: Text('Notifications', style: AppText.sectionTitle)),
                          _ToggleRow(label: 'Alertes température',   value: _alertesTemp,      onChanged: (v) => setState(() => _alertesTemp = v)),
                          Divider(height: 1, color: AppColors.divider),
                          _ToggleRow(label: 'Rapport quotidien',     value: _rapportQuotidien, onChanged: (v) => setState(() => _rapportQuotidien = v)),
                          Divider(height: 1, color: AppColors.divider),
                          _ToggleRow(label: 'SMS urgents',           value: _smsUrgents,       onChanged: (v) => setState(() => _smsUrgents = v)),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Déconnexion
                    SizedBox(
                      width: 200,
                      child: OutlinedButton(
                        onPressed: () => widget.onLogout('/login'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.critique,
                          side: const BorderSide(color: AppColors.critique, width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text('Se déconnecter', style: AppText.tableBold.copyWith(color: AppColors.critique)),
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

class _InfoSection extends StatelessWidget {
  final String title;
  final List<List<String>> rows;

  const _InfoSection({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 8), child: Text(title, style: AppText.sectionTitle)),
          ...rows.asMap().entries.map((e) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  children: [
                    Expanded(child: Text(e.value[0], style: AppText.tableCell.copyWith(color: AppColors.textSecondary))),
                    Text(e.value[1], style: AppText.tableBold),
                  ],
                ),
              ),
              if (e.key < rows.length - 1) Divider(height: 1, color: AppColors.divider),
            ],
          )),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppText.tableCell)),
          Switch(value: value, onChanged: onChanged,
            activeColor: AppColors.white, activeTrackColor: AppColors.primary,
            inactiveThumbColor: AppColors.white, inactiveTrackColor: AppColors.divider),
        ],
      ),
    );
  }
}
