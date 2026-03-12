import 'dart:ui';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blur;
  final double opacity;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 30,
    this.blur = 20,
    this.opacity = 0.8, 
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          // OUTER SHADOW (Matches ProductCard layer)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(10, 10),
                ),
              ],
            ),
          ),
          
          // MAIN GLASS BODY
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(
                padding: padding ?? const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF353F54).withOpacity(opacity),
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.0,
                    colors: [
                      const Color(0xFF353F54).withOpacity(0.8),
                      const Color(0xFF242C3B),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                    width: 0.5,
                  ),
                  boxShadow: [
                    // Inner Top-Left Highlight
                    BoxShadow(
                      color: Colors.white.withOpacity(0.08),
                      offset: const Offset(-4, -4),
                      blurRadius: 8,
                      inset: true,
                    ),
                    // Inner Bottom-Right Depth
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(6, 6),
                      blurRadius: 12,
                      inset: true,
                    ),
                  ],
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}