import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static TextStyle get heroLabel => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
        height: 16 / 12,
        color: AppColors.textMuted,
      );

  static TextStyle get heroTotal => GoogleFonts.hankenGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.6,
        height: 1,
        color: AppColors.textTitle,
      );

  static TextStyle get sectionTitle => GoogleFonts.hankenGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 32 / 24,
        color: AppColors.textPrimary,
      );

  static TextStyle get itemName => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 28 / 18,
        color: AppColors.textPrimary,
      );

  static TextStyle get itemNote => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
        color: AppColors.textMuted,
      );

  static TextStyle get amount => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        height: 24 / 20,
        color: AppColors.accent,
      );

  static TextStyle get subtotalLabel => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.8,
        height: 24 / 16,
        color: AppColors.textMuted,
      );

  static TextStyle get badge => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        height: 15 / 10,
      );

  static TextStyle get viewAll => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
        height: 16 / 12,
        color: AppColors.textMuted,
      );

  static TextStyle get buttonLabel => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
      );

  static TextStyle get appBarTitle => GoogleFonts.hankenGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get fieldLabel => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
        height: 16 / 12,
        color: AppColors.textMuted,
      );
}
