import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/sidebar.dart';
import 'widgets/top_bar.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/inventaire_screen.dart';
import 'screens/fiche_mouvement_temperature.dart';
import 'screens/alertes_rapports_parametres_profil.dart';

void main() {
  runApp(const MediStockApp());
}

class MediStockApp extends StatelessWidget {
  const MediStockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediStock IoT',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const AppShell(),
    );
  }
}

// ── App Shell — handles login + authenticated routing ─────────
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool   _isLoggedIn = false;
  String _currentRoute = '/dashboard';

  void _navigate(String route) {
    setState(() => _currentRoute = route);
  }

  void _login(String route) {
    setState(() {
      _isLoggedIn   = true;
      _currentRoute = route;
    });
  }

  void _logout(String route) {
    setState(() {
      _isLoggedIn   = false;
      _currentRoute = '/dashboard';
    });
  }

  Widget _buildScreen() {
    switch (_currentRoute) {
      case '/dashboard':    return const DashboardScreen();
      case '/inventaire':   return InventaireScreen(onNavigate: _navigate);
      case '/fiche':        return FicheMedicamentScreen(onNavigate: _navigate);
      case '/mouvement':    return const MouvementStockScreen();
      case '/temperature':  return const TemperatureScreen();
      case '/alertes':      return const AlertesScreen();
      case '/rapports':     return const RapportsScreen();
      case '/parametres':   return const ParametresScreen();
      case '/profil':       return ProfilScreen(onLogout: _logout);
      default:              return const DashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ── Not authenticated → Login ─────────────────────────────
    if (!_isLoggedIn) {
      return LoginScreen(onLogin: _login);
    }

    // ── Authenticated → Main layout ───────────────────────────
    return Scaffold(
      body: Row(
        children: [
          AppSidebar(
            currentRoute: _currentRoute,
            onNavigate: _navigate,
          ),
          Expanded(
            child: _buildScreen(),
          ),
        ],
      ),
    );
  }
}
