import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/neomorphic_button.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'docs_screen.dart';
import 'map_screen.dart';
import '../widgets/diagonal_background.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MapScreen(),
    const CartScreen(),
    const ProfileScreen(),
    const DocsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background 1: Custom Paint
          CustomPaint(size: Size.infinite, painter: HomeBackgroundPainter()),
          // Background 2: Soft Glowing Circles
          Positioned(
            right: -50,
            top: 50,
            child: Container(
              width: 300,
              height: 300,
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
          Positioned(
            left: -100,
            bottom: 100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accentBlue2.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Screen Content
          _screens[_selectedIndex],
          // Navbar
          Positioned(left: 0, right: 0, bottom: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppColors.background.withOpacity(0.8),
            AppColors.background,
          ],
        ),
      ),
      child: GlassCard(
        borderRadius: 40,
        opacity: 0.1,
        blur: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('assets/images/nav/bike.png', 0),
            _buildNavItem('assets/images/nav/map.png', 1),
            GestureDetector(
              onTap: () => setState(() => _selectedIndex = 2),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildNavItem('assets/images/nav/cart.png', 2),
                  Positioned(
                    top: -5, // Slightly higher
                    right: -5, // Slightly more right
                    child: Consumer<CartProvider>(
                      builder: (context, cart, child) {
                        if (cart.itemCount == 0) return const SizedBox.shrink();
                        return Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF4E4AF2),
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Text(
                            '${cart.itemCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            _buildNavItem('assets/images/nav/person.png', 3),
            _buildNavItem('assets/images/nav/doc.png', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String imagePath, int index) {
    bool isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: NeomorphicButton(
        padding: 10,
        borderRadius: 15,
        isPressed: isActive,
        gradient: isActive ? AppColors.blueGradient : null,
        onTap: () => setState(() => _selectedIndex = index),
        child: Image.asset(
          imagePath,
          color: isActive ? Colors.white : Colors.white24,
          width: 22,
          height: 22,
        ),
      ),
    );
  }
}
