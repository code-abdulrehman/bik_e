import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;
import '../theme/app_colors.dart';

class SlideToCheckout extends StatefulWidget {
  final VoidCallback onCompleted;
  const SlideToCheckout({super.key, required this.onCompleted});

  @override
  State<SlideToCheckout> createState() => _SlideToCheckoutState();
}

class _SlideToCheckoutState extends State<SlideToCheckout> {
  double _position = 0.0;
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Handle is 50px + 5px margin from each side
        double maxPosition = constraints.maxWidth - 60;

        return Container(
          height: 60,
          width: double.infinity,
          decoration: inset.BoxDecoration(
            // Dark Glass Base
            color: const Color(0xFF1A1F2B).withOpacity(0.5),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              // This creates the "Sunken" Dark Glass track effect
              inset.BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(4, 4),
                blurRadius: 10,
                inset: true,
              ),
              inset.BoxShadow(
                color: Colors.white.withOpacity(0.02),
                offset: const Offset(-2, -2),
                blurRadius: 5,
                inset: true,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Static Center Text
              Center(
                child: Text(
                  _isCompleted ? 'Processing...' : 'Slide to Checkout',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.4),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),

              // Dynamic Glowing Fill (Appears as you slide)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 50),
                  width: _position + 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accentBlue1.withOpacity(0.2),
                        AppColors.accentBlue1.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
              ),

              // The Sliding Handle
              Positioned(
                left: _position + 5,
                top: 5,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (_isCompleted) return;
                    setState(() {
                      _position += details.delta.dx;
                      if (_position < 0) _position = 0;
                      if (_position > maxPosition) _position = maxPosition;
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    if (_isCompleted) return;
                    if (_position > maxPosition * 0.8) {
                      setState(() {
                        _position = maxPosition;
                        _isCompleted = true;
                      });
                      widget.onCompleted();
                    } else {
                      setState(() {
                        _position = 0;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: AppColors.blueGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentBlue1.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: _isCompleted
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Image.asset(
                              'assets/images/icons/chevron-forward.png',
                              color: Colors.white,
                              width: 22,
                              height: 22,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}