import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/diagonal_background.dart';
import '../widgets/neomorphic_button.dart';
import '../widgets/glass_card.dart';
import '../providers/cart_provider.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isSpecTab = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomPaint(size: Size.infinite, painter: HomeBackgroundPainter()),
          Positioned(
            right: -50,
            top: 100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accentBlue1.withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NeomorphicButton(
                        onTap: () => Navigator.pop(context),
                        padding: 10,
                        borderRadius: 15,
                        child: Image.asset(
                          'assets/images/icons/chevron-left.png',
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      Text(
                        widget.product.name,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final provider = context.read<ProductProvider>();
                          provider.toggleFavorite(widget.product.id);
                          final isFav = provider.isFavorite(widget.product.id);
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
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.accentBlue1.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Consumer<ProductProvider>(
                            builder: (context, provider, _) {
                              final isFav = provider.isFavorite(
                                widget.product.id,
                              );
                              return Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: AppColors.accentBlue1,
                                size: 24,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: 50,
                          child: Container(
                            width: 200,
                            height: 20,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Hero(
                          tag: 'product-${widget.product.id}',
                          child: Image.asset(
                            widget.product.imageUrl,
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width * 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GlassCard(
                      borderRadius: 40,
                      opacity: 0.1,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: NeomorphicButton(
                                    padding: 10,
                                    borderRadius: 15,
                                    gradient: !isSpecTab
                                        ? AppColors.blueGradient
                                        : null,
                                    onTap: () =>
                                        setState(() => isSpecTab = false),
                                    child: Center(
                                      child: Text(
                                        'Description',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: NeomorphicButton(
                                    padding: 10,
                                    borderRadius: 15,
                                    gradient: isSpecTab
                                        ? AppColors.blueGradient
                                        : null,
                                    onTap: () =>
                                        setState(() => isSpecTab = true),
                                    child: Center(
                                      child: Text(
                                        'Specification',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: SingleChildScrollView(
                                child: !isSpecTab
                                    ? Text(
                                        widget.product.description,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          height: 1.5,
                                        ),
                                      )
                                    : Column(
                                        children: widget
                                            .product
                                            .specifications
                                            .entries
                                            .map((e) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 5.0,
                                                    ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      e.key,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color:
                                                                Colors.white60,
                                                            fontSize: 14,
                                                          ),
                                                    ),
                                                    Text(
                                                      e.value,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                            .toList(),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white54,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '\$${widget.product.price.toStringAsFixed(2)}',
                                      style: GoogleFonts.poppins(
                                        color: AppColors.textPrice,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 80,
                                  child: NeomorphicButton(
                                    padding: 18,
                                    borderRadius: 20,
                                    gradient: AppColors.blueGradient,
                                    onTap: () {
                                      context.read<CartProvider>().addItem(
                                        widget.product,
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Added to cart'),
                                          duration: Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/nav/cart.png',
                                        color: Colors.white,
                                        width: 24,
                                        height: 24,
                                      ),
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
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
