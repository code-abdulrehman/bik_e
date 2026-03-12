import 'package:flutter/material.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;

class NeomorphicButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool isPressed;
  final double padding;
  final double borderRadius;
  final Gradient? gradient;
  final double? width;
  final double? height;

  const NeomorphicButton({
    super.key,
    required this.child,
    required this.onTap,
    this.isPressed = false,
    this.padding = 15.0,
    this.borderRadius = 15,
    this.gradient,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: inset.BoxDecoration(
          color: gradient == null ? const Color(0xFF353F54) : null,
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: isPressed
              ? [
                  inset.BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(4, 4),
                    blurRadius: 10,
                    inset: true,
                  ),
                  inset.BoxShadow(
                    color: Colors.white.withOpacity(0.05),
                    offset: const Offset(-4, -4),
                    blurRadius: 10,
                    inset: true,
                  ),
                ]
              : [
                  inset.BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(4, 4),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                  inset.BoxShadow(
                    color: Colors.white.withOpacity(0.05),
                    offset: const Offset(-4, -4),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: child,
      ),
    );
  }
}
