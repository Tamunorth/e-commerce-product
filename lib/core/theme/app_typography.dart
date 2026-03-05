import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  const AppTypography._();

  // Display - Gelasio (serif, editorial feel from Figma)
  static TextStyle displayLarge = GoogleFonts.gelasio(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static TextStyle displayMedium = GoogleFonts.gelasio(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  static TextStyle displaySmall = GoogleFonts.gelasio(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  // Headings - Space Grotesk (geometric, tight)
  static TextStyle headlineLarge = GoogleFonts.spaceGrotesk(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
  );

  static TextStyle headlineMedium = GoogleFonts.spaceGrotesk(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  );

  static TextStyle headlineSmall = GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  // Body - Nunito Sans (from Figma, friendly and readable)
  static TextStyle bodyLarge = GoogleFonts.nunitoSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodyMedium = GoogleFonts.nunitoSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodySmall = GoogleFonts.nunitoSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  // Labels
  static TextStyle labelLarge = GoogleFonts.nunitoSans(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static TextStyle labelMedium = GoogleFonts.nunitoSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static TextStyle labelSmall = GoogleFonts.nunitoSans(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // Price
  static TextStyle priceLarge = GoogleFonts.nunitoSans(
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );

  static TextStyle priceMedium = GoogleFonts.nunitoSans(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  // Button
  static TextStyle button = GoogleFonts.nunitoSans(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle buttonSmall = GoogleFonts.nunitoSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}
