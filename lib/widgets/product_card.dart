import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Outer Shadow Layer
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipPath(
              clipper: OrganicCardClipper(),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(10, 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Main Card Body
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipPath(
              clipper: OrganicCardClipper(),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF353F54),
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.0,
                    colors: [
                      const Color(0xFF353F54).withOpacity(0.8),
                      const Color(0xFF242C3B),
                    ],
                  ),
                  boxShadow: [
                    // Beveled highlight (Inner Top-Left)
                    BoxShadow(
                      color: Colors.white.withOpacity(0.08),
                      offset: const Offset(-4, -4),
                      blurRadius: 8,
                      inset: true,
                    ),
                    // Deep inner shadow (Inner Bottom-Right)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(6, 6),
                      blurRadius: 12,
                      inset: true,
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  top: 15.0,
                  bottom: 30.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight, // Heart on the right
                      child: GestureDetector(
                        onTap: () {
                          final provider = context.read<ProductProvider>();
                          provider.toggleFavorite(product.id);
                          final isFav = provider.isFavorite(product.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isFav
                                    ? 'Added to Favorites'
                                    : 'Removed from Favorites',
                              ),
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accentBlue1.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Consumer<ProductProvider>(
                            builder: (context, provider, _) {
                              final isFav = provider.isFavorite(product.id);
                              return Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: AppColors.accentBlue1,
                                size: 18,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            bottom: 10,
                            child: Container(
                              width: 80,
                              height: 10,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Hero(
                            tag: 'product-${product.id}',
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Center(
                                  child: Image.asset(
                                    product.imageUrl,
                                    fit: BoxFit.contain,
                                    width:
                                        constraints.maxWidth * 0.8, // 80% width
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      product.brand.toUpperCase(),
                      style: GoogleFonts.poppins(
                        color: Colors.white54,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.name.toUpperCase(),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Price on the left
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.textPrice.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              color: AppColors.textPrice,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for the "Opposite" organic card shape
class OrganicCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // MIRRORED DESIGN
    // Start at the Top-Right (high point)
    path.moveTo(size.width, size.height * 0.08);
    path.quadraticBezierTo(size.width, 0, size.width * 0.85, 0);

    // Slant DOWN toward the Top-Left
    path.lineTo(size.width * 0.15, size.height * 0.08);
    path.quadraticBezierTo(0, size.height * 0.1, 0, size.height * 0.25);

    // Drop to the Bottom-Left (low point)
    path.lineTo(0, size.height * 0.92);
    path.quadraticBezierTo(0, size.height, size.width * 0.15, size.height);

    // Slant UP toward the Bottom-Right
    path.lineTo(size.width * 0.85, size.height * 0.92);
    path.quadraticBezierTo(
      size.width,
      size.height * 0.9,
      size.width,
      size.height * 0.75,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
