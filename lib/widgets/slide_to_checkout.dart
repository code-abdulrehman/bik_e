import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        double maxPosition =
            constraints.maxWidth - 60; // Button width is 50 + padding
        return Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground.withOpacity(0.3),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white10, width: 0.5),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  _isCompleted ? 'Processing...' : 'Checkout',
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              // Filling Color
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: _position + 55, // 50 (handle) + 5 (margin)
                  decoration: BoxDecoration(
                    gradient: AppColors.blueGradient,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Positioned(
                left: _position + 5,
                top: 5,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _position += details.delta.dx;
                      if (_position < 0) _position = 0;
                      if (_position > maxPosition) _position = maxPosition;
                    });
                  },
                  onHorizontalDragEnd: (details) {
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
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: AppColors.blueGradient,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentBlue2.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/icons/chevron-forward.png',
                      color: Colors.white,
                      width: 24,
                      height: 24,
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
