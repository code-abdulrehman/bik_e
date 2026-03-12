import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'neomorphic_button.dart';

class EmptyState extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;

  const EmptyState({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          NeomorphicButton(
            onTap: () {},
            padding: 20,
            borderRadius: 20,
            child: Opacity(
              opacity: 0.9,
              child: Image.asset(
                iconPath,
                width: 30,
                height: 30,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              description,
              style: GoogleFonts.poppins(color: Colors.white54, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
