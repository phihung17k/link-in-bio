import 'package:flutter/material.dart';

// Primary: base, key component: FAB, button, active state
//  => On Primary: content(icon, text, etc.) on top of primary
// Primary container: less emphasis than primary
//  => On Primary Container: content(icon, text, .) on top of primary container

// Neutral: Surfaces and Outlines, Background

// Secondary: less prominent components: filter chips, etc.

// Tertiary: balance primary and secondary,  bring attention to an element,
//such as an input field.

// Surface: contained area from a background and other elements

class ColorSchemes {
  static ColorScheme get lightPinkScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFAB00A2),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFFFFD7F3),
        onPrimaryContainer: Color(0xFF390035),
        secondary: Color(0xFF6E5868),
        onSecondary: Color(0xFFFFFFFF),
        secondaryContainer: Color(0xFFF8DAEE),
        onSecondaryContainer: Color(0xFF271624),
        tertiary: Color(0xFF815343),
        onTertiary: Color(0xFFFFFFFF),
        tertiaryContainer: Color(0xFFFFDBD0),
        onTertiaryContainer: Color(0xFF321207),
        error: Color(0xFFBA1A1A),
        errorContainer: Color(0xFFFFDAD6),
        onError: Color(0xFFFFFFFF),
        onErrorContainer: Color(0xFF410002),
        background: Color(0xFFFFFBFF),
        onBackground: Color(0xFF1F1A1D),
        surface: Color(0xFFFFFBFF),
        onSurface: Color(0xFF1F1A1D),
        surfaceVariant: Color(0xFFEEDEE7),
        onSurfaceVariant: Color(0xFF4E444B),
        outline: Color(0xFF80747B),
        onInverseSurface: Color(0xFFF8EEF2),
        inverseSurface: Color(0xFF342F32),
        inversePrimary: Color(0xFFFFABEE),
        shadow: Color(0xFF000000),
        surfaceTint: Color(0xFFAB00A2),
        outlineVariant: Color(0xFFD2C2CB),
        scrim: Color(0xFF000000),
      );
  static ColorScheme get darkPinkScheme => const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFFFABEE),
        onPrimary: Color(0xFF5C0057),
        primaryContainer: Color(0xFF83007C),
        onPrimaryContainer: Color(0xFFFFD7F3),
        secondary: Color(0xFFDBBED1),
        onSecondary: Color(0xFF3E2A39),
        secondaryContainer: Color(0xFF554050),
        onSecondaryContainer: Color(0xFFF8DAEE),
        tertiary: Color(0xFFF5B9A5),
        onTertiary: Color(0xFF4C2619),
        tertiaryContainer: Color(0xFF663C2D),
        onTertiaryContainer: Color(0xFFFFDBD0),
        error: Color(0xFFFFB4AB),
        errorContainer: Color(0xFF93000A),
        onError: Color(0xFF690005),
        onErrorContainer: Color(0xFFFFDAD6),
        background: Color(0xFF1F1A1D),
        onBackground: Color(0xFFEAE0E4),
        surface: Color(0xFF1F1A1D),
        onSurface: Color(0xFFEAE0E4),
        surfaceVariant: Color(0xFF4E444B),
        onSurfaceVariant: Color(0xFFD2C2CB),
        outline: Color(0xFF9A8D95),
        onInverseSurface: Color(0xFF1F1A1D),
        inverseSurface: Color(0xFFEAE0E4),
        inversePrimary: Color(0xFFAB00A2),
        shadow: Color(0xFF000000),
        surfaceTint: Color(0xFFFFABEE),
        outlineVariant: Color(0xFF4E444B),
        scrim: Color(0xFF000000),
      );
}
