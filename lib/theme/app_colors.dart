import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF242C3B);
  static const Color secondaryBackground = Color(0xFF353F54);
  static const Color accentBlue1 = Color(0xFF34C8E8);
  static const Color accentBlue2 = Color(0xFF4E4AF2);
  static const Color cardBorder = Colors.white24;
  static const Color textPrice = Color(0xFF34C8E8);

  static const LinearGradient blueGradient = LinearGradient(
    colors: [accentBlue1, accentBlue2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF353F54), Color(0xFF222834)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
