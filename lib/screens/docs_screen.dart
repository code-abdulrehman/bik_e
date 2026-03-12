import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/glass_card.dart';

class DocsScreen extends StatelessWidget {
  const DocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Documents',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.search, color: Colors.white54),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Recent Documents',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildDocItem(
                      'Warranty Policy',
                      'v2.1 - PDF - 1.2 MB',
                      Icons.security,
                      const Color(0xFF4CAF50),
                    ),
                    _buildDocItem(
                      'User Manual',
                      'v1.5 - PDF - 4.5 MB',
                      Icons.menu_book,
                      const Color(0xFF2196F3),
                    ),
                    _buildDocItem(
                      'Maintenance Guide',
                      'v1.0 - PDF - 2.8 MB',
                      Icons.settings_suggest,
                      const Color(0xFFFF9800),
                    ),
                    _buildDocItem(
                      'Assembly Instructions',
                      'v3.2 - PDF - 5.1 MB',
                      Icons.build,
                      const Color(0xFFE91E63),
                    ),
                    _buildDocItem(
                      'Safety Standards',
                      'v1.1 - PDF - 0.9 MB',
                      Icons.gpp_good,
                      const Color(0xFF9C27B0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocItem(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GlassCard(
        borderRadius: 20,
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            title: Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: GoogleFonts.poppins(color: Colors.white54, fontSize: 11),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.download,
                color: Colors.white70,
                size: 20,
              ),
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
