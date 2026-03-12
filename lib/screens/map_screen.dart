import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Fixed import
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/diagonal_background.dart';
import '../widgets/glass_card.dart';
import '../widgets/neomorphic_button.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Painter (Underneath map for transparency effect if desired)
          CustomPaint(size: Size.infinite, painter: HomeBackgroundPainter()),

          // REAL MAP SECTION
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(33.6844, 73.0479), // Islamabad coord
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.bike', 
                subdomains: const ['a', 'b', 'c'],
                // Apply a dark/blue filter to match app theme
                tileBuilder: (context, tileWidget, tile) {
                  return ColorFiltered(
                    colorFilter: const ColorFilter.matrix([
                      -0.5, -0.5, -0.5, 0, 100, // Even darker red channel
                      -0.5, -0.5, -0.5, 0, 100, // Even darker green channel
                      -0.5, -0.5, -0.5, 0, 100, // Even darker blue channel
                      0, 0, 0, 1, 0, // Alpha
                    ]),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        const Color(0xFF1B232E).withOpacity(0.85),
                        BlendMode.multiply,
                      ),
                      child: tileWidget,
                    ),
                  );
                },
              ),
              MarkerLayer(markers: _buildMarkers()),
            ],
          ),

          // Header Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bike Stations',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GlassCard(
                    borderRadius: 21,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.white54,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Search stations...',
                                hintStyle: TextStyle(
                                  color: Colors.white24,
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
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

          // Bottom Info Card
          Positioned(
            bottom: 120,
            left: 20,
            right: 20,
            child: GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Centaurus Station',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentBlue1.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '2.4 km',
                          style: GoogleFonts.poppins(
                            color: AppColors.accentBlue1,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '12 Bikes Available • 4 Slots Free',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 15),
                  NeomorphicButton(
                    padding: 12,
                    width: double.infinity,
                    gradient: AppColors.blueGradient,
                    onTap: () {},
                    child: Center(
                      child: Text(
                        'Route to Station',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Marker> _buildMarkers() {
    return [
      // REMOVED 'const' FROM HERE
      _createMarker(LatLng(33.6844, 63.2470)), // Centaurus
      _createMarker(LatLng(31.6944, 73.0159)),
      _createMarker(LatLng(33.6454, 74.0369)),
      _createMarker(LatLng(31.7003, 31.0679)),
      _createMarker(LatLng(30.6612, 73.0369)),
      _createMarker(LatLng(13.7044, 73.0620)),
      _createMarker(LatLng(33.7144, 73.0779)), // Near Faisal Mosque area
      _createMarker(LatLng(33.6844, 73.0279)), // F-9 Park area
      _createMarker(LatLng(33.6644, 73.0579)), // Blue Area
    ];
  }

  // This part is fine, just ensure ll2 prefix is used consistently
  Marker _createMarker(LatLng point) {
    return Marker(
      point: point,
      width: 60,
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulse Animation / Glow
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentBlue1.withValues(alpha: 0.4),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),
          // Pointer Shape
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.accentBlue1,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.pedal_bike,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -8),
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(45 / 360),
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppColors.accentBlue1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
