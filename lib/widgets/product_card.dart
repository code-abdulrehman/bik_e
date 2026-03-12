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

  // Set the radius here to make it easy to change everywhere at once
  static const double cardRadius = 30.0;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // 1. OUTER SHADOW LAYER
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cardRadius),
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
          
          // 2. MAIN CARD BODY
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cardRadius),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(cardRadius),
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
                    // Favorite Toggle
                    Align(
                      alignment: Alignment.topRight,
                      child: _buildFavoriteIcon(context),
                    ),
                    
                    // Product Image with Floor Shadow
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
                            child: Image.asset(
                              product.imageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Brand & Name
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
                    
                    // Price
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        color: AppColors.textPrice,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: AppColors.textPrice.withOpacity(0.3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
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

  Widget _buildFavoriteIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final provider = context.read<ProductProvider>();
        provider.toggleFavorite(product.id);
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
    );
  }
}