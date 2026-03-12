import 'package:flutter/material.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/neomorphic_button.dart';
import '../widgets/slide_to_checkout.dart';
import '../widgets/diagonal_background.dart';
import '../widgets/empty_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController(
    text: 'Islamabad, Sector F-6, Street 4, House 12',
  );
  final TextEditingController _paymentController = TextEditingController(
    text: 'Visa **** 4242',
  );

  bool _isEditingAddress = false;
  bool _isEditingPayment = false;

  @override
  void dispose() {
    _promoController.dispose();
    _addressController.dispose();
    _paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final cartItems = cart.items.values.toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          CustomPaint(size: Size.infinite, painter: HomeBackgroundPainter()),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
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
                      const SizedBox(width: 10),
                      Text(
                        'My Cart',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: cartItems.isEmpty
                      ? const EmptyState(
                          iconPath: 'assets/images/nav/cart.png',
                          title: 'Your cart is empty',
                          description:
                              'Looks like you haven\'t added any bikes to your cart yet.',
                        )
                      : ListView(
                          padding: const EdgeInsets.all(20),
                          children: [
                            ...cartItems.map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: GlassCard(
                                  height: 100,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.01),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.10, // Exactly 20% of screen width
                                          child: Image.asset(
                                            item.product.imageUrl,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.product.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                              width: 10,
                                            ),
                                            Text(
                                              '\$ ${item.product.price}',
                                              style: GoogleFonts.poppins(
                                                color: AppColors.textPrice,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          _QuantityButton(
                                            icon: Icons.remove,
                                            onTap: () => cart.removeSingleItem(
                                              item.product.id,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                            ),
                                            child: SizedBox(
                                              width:
                                                  30, // Adjust this value based on your design needs
                                              child: Text(
                                                '${item.quantity}',
                                                textAlign: TextAlign
                                                    .center, // Keeps the number centered in the fixed width
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          _QuantityButton(
                                            icon: Icons.add,
                                            onTap: () =>
                                                cart.addItem(item.product),
                                            isAdd: true,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 15),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),
                            _buildEditableSection(
                              'Shipping Address',
                              _addressController,
                              _isEditingAddress,
                              () => setState(
                                () => _isEditingAddress = !_isEditingAddress,
                              ),
                            ),
                            const SizedBox(height: 15),
                            _buildEditableSection(
                              'Payment Method',
                              _paymentController,
                              _isEditingPayment,
                              () => setState(
                                () => _isEditingPayment = !_isEditingPayment,
                              ),
                            ),
                            const SizedBox(height: 30),

                            // Promo Code
                            Row(
                              children: [
                                Expanded(
                                  child: GlassCard(
                                    height: 55,
                                    borderRadius: 30,
                                    padding: EdgeInsets
                                        .zero, // Important to keep the TextField alignment
                                    child: Container(
                                      // Using a container inside to apply the inset shadow
                                      decoration: inset.BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          inset.BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.4,
                                            ),
                                            offset: const Offset(4, 4),
                                            blurRadius: 8,
                                            inset: true,
                                          ),
                                          inset.BoxShadow(
                                            color: Colors.white.withOpacity(
                                              0.05,
                                            ),
                                            offset: const Offset(-2, -2),
                                            blurRadius: 4,
                                            inset: true,
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        controller: _promoController,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Promo Code',
                                          hintStyle: GoogleFonts.poppins(
                                            color: Colors.white24,
                                            fontSize: 14,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 15,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                NeomorphicButton(
                                  padding:
                                      14, // Slightly more padding to match height of input
                                  borderRadius: 30,
                                  gradient: AppColors.blueGradient,
                                  onTap: () {
                                    if (_promoController.text.toUpperCase() ==
                                        'BIKE20') {
                                      cart.applyDiscount(20);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Promo BIKE20 applied! 20% discount',
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Invalid Promo Code. Try BIKE20',
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Apply',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),

                            // Summary
                            GlassCard(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  _SummaryRow(
                                    label: 'Subtotal',
                                    value:
                                        '\$ ${cart.subtotal.toStringAsFixed(2)}',
                                  ),
                                  _SummaryRow(
                                    label: 'Delivery Fee',
                                    value: '\$ 5.00',
                                  ),
                                  _SummaryRow(
                                    label: 'Discount',
                                    value:
                                        '${cart.discountPercentage.toInt()}%',
                                  ),
                                  const Divider(
                                    color: Colors.white12,
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '\$ ${(cart.totalAmount + 5).toStringAsFixed(2)}',
                                        style: GoogleFonts.poppins(
                                          color: AppColors.textPrice,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            SlideToCheckout(
                              onCompleted: () {
                                _showSuccessDialog(context, cart);
                              },
                            ),
                            const SizedBox(height: 150), // Increased padding
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableSection(
    String title,
    TextEditingController controller,
    bool isEditing,
    VoidCallback onEditToggle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Expanded(
                child: isEditing
                    ? TextField(
                        controller: controller,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        autofocus: true,
                      )
                    : Text(
                        controller.text,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
              ),
              GestureDetector(
                onTap: onEditToggle,
                child: isEditing
                    ? const Icon(
                        Icons.check_circle,
                        color: Color(0xFF4CAF50),
                        size: 24,
                      )
                    : const Icon(
                        Icons.edit,
                        color: AppColors.accentBlue1,
                        size: 18,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSuccessDialog(BuildContext context, CartProvider cart) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF242C3B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.accentBlue1.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppColors.accentBlue1,
                size: 80,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Order Placed!',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Your bike is on its way.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 40),
            NeomorphicButton(
              padding: 15,
              width: double.infinity,
              gradient: AppColors.blueGradient,
              onTap: () {
                cart.clear();
                // To redirect to home page, we can use pushNamedAndRemoveUntil or just pop everything
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/', (route) => false);
              },
              child: Center(
                child: Text(
                  'Continue Shopping',
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
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(color: Colors.white60, fontSize: 16),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isAdd;
  const _QuantityButton({
    required this.icon,
    required this.onTap,
    this.isAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: isAdd ? AppColors.blueGradient : null,
          color: isAdd ? null : const Color(0xFF353F54),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
