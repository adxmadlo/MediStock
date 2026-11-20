import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // ── Sidebar ─────────────────────────────────────────────────
  static const Color sidebarBg       = Color(0xFF1A5C2A);
  static const Color sidebarHover    = Color(0xFF245C33);
  static const Color sidebarActive   = Color(0xFF2E7D32);
  static const Color sidebarText     = Color(0xFFFFFFFF);
  static const Color sidebarSubtext  = Color(0xFFA5D6A7);

  // ── Content ──────────────────────────────────────────────────
  static const Color contentBg       = Color(0xFFF0F7F0);
  static const Color cardBg          = Color(0xFFFFFFFF);
  static const Color topBarBg        = Color(0xFFFFFFFF);
  static const Color divider         = Color(0xFFE0EEE0);

  // ── Text ─────────────────────────────────────────────────────
  static const Color textPrimary     = Color(0xFF0F172A);
  static const Color textSecondary   = Color(0xFF475569);
  static const Color textMuted       = Color(0xFF94A3B8);

  // ── Status colors ─────────────────────────────────────────────
  static const Color statusOk        = Color(0xFF2E7D32);
  static const Color statusOkBg      = Color(0xFFE8F5E9);
  static const Color statusRupture   = Color(0xFFC62828);
  static const Color statusRuptureBg = Color(0xFFFFEBEE);
  static const Color statusStockBas  = Color(0xFFE65100);
  static const Color statusStockBasBg= Color(0xFFFFF3E0);
  static const Color statusExpire    = Color(0xFF388E3C);
  static const Color statusExpireBg  = Color(0xFFF1F8E9);

  // ── Alert severity ───────────────────────────────────────────
  static const Color critique        = Color(0xFFC62828);
  static const Color critiqueBg      = Color(0xFFFFEBEE);
  static const Color avertissement   = Color(0xFFEF6C00);
  static const Color avertissementBg = Color(0xFFFFF3E0);
  static const Color stockBas        = Color(0xFFE65100);
  static const Color systeme         = Color(0xFF1565C0);
  static const Color systemeBg       = Color(0xFFE3F2FD);

  // ── Roles ────────────────────────────────────────────────────
  static const Color pharmacien      = Color(0xFF2E7D32);
  static const Color personnel       = Color(0xFF1565C0);
  static const Color technicien      = Color(0xFF6A1B9A);
  static const Color administrateur  = Color(0xFF2E7D32);

  // ── Charts ───────────────────────────────────────────────────
  static const Color chartGreen      = Color(0xFF2E7D32);
  static const Color chartGreenLight = Color(0xFF81C784);
  static const Color chartBlue       = Color(0xFF1565C0);
  static const Color chartRed        = Color(0xFFC62828);
  static const Color chartOrange     = Color(0xFFE65100);

  // ── KPI values ───────────────────────────────────────────────
  static const Color kpiAlertes      = Color(0xFFC62828);
  static const Color kpiStockBas     = Color(0xFFE65100);
  static const Color kpiExpirations  = Color(0xFF1565C0);
  static const Color kpiCapteurs     = Color(0xFF2E7D32);

  // ── Primary ──────────────────────────────────────────────────
  static const Color primary         = Color(0xFF1A5C2A);
  static const Color primaryLight    = Color(0xFF4CAF50);
  static const Color white           = Color(0xFFFFFFFF);
}

class AppTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary:    AppColors.primary,
      secondary:  AppColors.statusOk,
      surface:    AppColors.cardBg,
      background: AppColors.contentBg,
      error:      AppColors.critique,
    ),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
      displayMedium:GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
      displaySmall: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
      headlineMedium:GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      headlineSmall: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      titleLarge:   GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      titleMedium:  GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
      bodyLarge:    GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textPrimary),
      bodyMedium:   GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
      bodySmall:    GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textMuted),
      labelLarge:   GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      labelSmall:   GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textMuted, letterSpacing: 0.5),
    ),
    scaffoldBackgroundColor: AppColors.contentBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.topBarBg,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardTheme(
      color: AppColors.cardBg,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardBg,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.divider)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.divider)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.textMuted),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1, space: 0),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((s) => s.contains(MaterialState.selected) ? AppColors.white : AppColors.textMuted),
      trackColor: MaterialStateProperty.resolveWith((s) => s.contains(MaterialState.selected) ? AppColors.primary : AppColors.divider),
    ),
  );
}

// ── Shared decorations ────────────────────────────────────────
class AppDecorations {
  static BoxDecoration get card => BoxDecoration(
    color: AppColors.cardBg,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
  );

  static BoxDecoration get cardBorder => BoxDecoration(
    color: AppColors.cardBg,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: AppColors.divider, width: 1),
  );

  static BoxDecoration sidebar = const BoxDecoration(color: AppColors.sidebarBg);
  static BoxDecoration topBar  = const BoxDecoration(
    color: AppColors.topBarBg,
    border: Border(bottom: BorderSide(color: AppColors.divider, width: 1)),
  );
}

// ── Text styles shortcuts ─────────────────────────────────────
class AppText {
  static TextStyle kpiValue(Color color) => GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700, color: color);
  static TextStyle kpiLabel  = GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textSecondary);
  static TextStyle tableHdr  = GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary, letterSpacing: 0.3);
  static TextStyle tableCell = GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textPrimary);
  static TextStyle tableBold = GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static TextStyle sectionTitle = GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary);
  static TextStyle pageTitle    = GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary);
  static TextStyle sidebarLabel = GoogleFonts.inter(fontSize: 9,  fontWeight: FontWeight.w600, color: AppColors.sidebarSubtext, letterSpacing: 1.0);
  static TextStyle navItem      = GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.sidebarText);
  static TextStyle navItemActive= GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.sidebarText);
}
