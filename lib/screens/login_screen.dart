import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  final Function(String route) onLogin;
  const LoginScreen({super.key, required this.onLogin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _selectedRole = 0;
  bool _rememberMe = false;
  final _emailCtrl = TextEditingController(text: 'f.sarr@medistock.sn');
  final _pwdCtrl   = TextEditingController(text: '••••••••••');

  final List<Map<String,String>> _roles = [
    {'titre':'Pharmacien',       'sub':'Accès élevé'},
    {'titre':'Personnel soignant','sub':'Infirmier · accès limité'},
    {'titre':'Technicien IoT',   'sub':'Config. capteurs'},
    {'titre':'Administrateur',   'sub':'Accès total'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // ── Colonne gauche : branding ─────────────────────────
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(color: AppColors.sidebarBg),
              padding: const EdgeInsets.all(48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Row(
                    children: [
                      Container(
                        width: 48, height: 48,
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.favorite, color: Colors.white, size: 26),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text('MediStock', style: TextStyle(fontSize: 52, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -1)),
                  const SizedBox(height: 16),
                  Text('Surveillez vos stocks et la chaîne\ndu froid, en temps réel.',
                    style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.75), height: 1.6)),
                  const Spacer(),
                  // Stats bottom
                  Row(
                    children: [
                      _statItem('4/4', 'Capteurs actifs'),
                      const SizedBox(width: 40),
                      _statItem('128', 'Médicaments suivis'),
                      const SizedBox(width: 40),
                      _statItem('24/7', 'Surveillance'),
                    ],
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),

          // ── Colonne droite : formulaire ───────────────────────
          Expanded(
            flex: 5,
            child: Container(
              color: const Color(0xFFF2F8F2),
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 40),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Connexion', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.primary)),
                      const SizedBox(height: 6),
                      Text('Sélectionnez votre profil pour continuer',
                        style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                      const SizedBox(height: 28),

                      // Profil grid
                      GridView.count(
                        crossAxisCount: 2, shrinkWrap: true,
                        mainAxisSpacing: 12, crossAxisSpacing: 12,
                        childAspectRatio: 2.8,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(_roles.length, (i) {
                          final isActive = _selectedRole == i;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedRole = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: isActive ? AppColors.primary : AppColors.cardBg,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: isActive ? AppColors.primary : AppColors.divider, width: 1.5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_roles[i]['titre']!, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: isActive ? Colors.white : AppColors.textPrimary)),
                                  Text(_roles[i]['sub']!,  style: TextStyle(fontSize: 11, color: isActive ? Colors.white.withOpacity(0.8) : AppColors.textMuted)),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 28),

                      // Email
                      Text('Adresse email', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailCtrl,
                        decoration: InputDecoration(
                          hintText: 'f.sarr@medistock.sn',
                          filled: true, fillColor: AppColors.cardBg,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password
                      Text('Mot de passe', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _pwdCtrl,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '••••••••••',
                          filled: true, fillColor: AppColors.cardBg,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Remember + forgot
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => _rememberMe = !_rememberMe),
                            child: Row(
                              children: [
                                Container(
                                  width: 18, height: 18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.divider, width: 1.5),
                                    color: _rememberMe ? AppColors.primary : AppColors.cardBg,
                                  ),
                                  child: _rememberMe ? const Icon(Icons.check, color: Colors.white, size: 12) : null,
                                ),
                                const SizedBox(width: 8),
                                Text('Se souvenir de moi', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text('Mot de passe oublié ?', style: TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Submit
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () => widget.onLogin('/dashboard'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          ),
                          child: Text('Se connecter', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text('Le menu s\'adapte automatiquement aux droits du profil sélectionné',
                          style: TextStyle(fontSize: 12, color: AppColors.textMuted), textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
      Text(label, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6))),
    ],
  );
}
