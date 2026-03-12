import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../widgets/neomorphic_button.dart';
import '../widgets/product_card.dart';
import '../widgets/empty_state.dart';
import 'detail_screen.dart';

import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchExpanded = false;

  @override
  Widget build(BuildContext context) {
    final allProducts = context.watch<ProductProvider>().products;
    List<Product> filteredProducts = allProducts.where((product) {
      bool searchMatch =
          product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          product.brand.toLowerCase().contains(searchQuery.toLowerCase());
      return searchMatch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        NeomorphicButton(
                          onTap: () {},
                          padding: 10,
                          borderRadius: 15,
                          child: Image.asset(
                            'assets/images/nav/bike.png',
                            color: Colors.white,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Bik_e',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _isSearchExpanded ? 180 : 44,
                    height: 44,
                    child: NeomorphicButton(
                      padding: 10,
                      gradient: AppColors.blueGradient,
                      onTap: () {
                        setState(() {
                          _isSearchExpanded = !_isSearchExpanded;
                          if (!_isSearchExpanded) {
                            searchQuery = '';
                            _searchController.clear();
                          }
                        });
                      },
                      child: _isSearchExpanded
                          ? TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() => searchQuery = value);
                              },
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Search...',
                                hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            )
                          : Image.asset(
                              'assets/images/icons/search.png',
                              color: Colors.white,
                              width: 16,
                              height: 16,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (filteredProducts.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Featured Product',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetailScreen(product: filteredProducts[6]),
                            ),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                  height: 240,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xFF353F54),
                                    gradient: RadialGradient(
                                      colors: [
                                        const Color(
                                          0xFF353F54,
                                        ).withOpacity(0.8),
                                        const Color(0xFF242C3B),
                                      ],
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '30% OFF',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'NEW ARRIVAL',
                                        style: GoogleFonts.poppins(
                                          color: AppColors.accentBlue1,
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              // Big Cycle Image
                              Positioned(
                                right: -20,
                                bottom: 0,
                                child: Hero(
                                  tag: 'featured-bike',
                                  child: Image.asset(
                                    'assets/images/products/electric-bicycle.png',
                                    height: 250,
                                    width: 345,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                    // Product Grid or Empty State
                    if (filteredProducts.isEmpty)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: const Center(
                          child: EmptyState(
                            iconPath: 'assets/images/nav/bike.png',
                            title: 'Products not found',
                            description:
                                'Try searching for a different bike or brand.',
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: GridView.builder(
                            key: ValueKey(searchQuery),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      0.68, // slightly taller for asymmetric clipper
                                  crossAxisSpacing: 10
                                ),
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = filteredProducts[index];
                              return ProductCard(
                                product: product,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        DetailScreen(product: product),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    const SizedBox(height: 120), // Space for navbar
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
