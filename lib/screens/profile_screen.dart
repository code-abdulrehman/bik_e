import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Controllers
  final TextEditingController _nameController = TextEditingController(text: 'Abdul Rehman');
  final TextEditingController _bioController = TextEditingController(text: 'Bike Enthusiast');
  final TextEditingController _emailController = TextEditingController(text: 'abdul@example.com');
  final TextEditingController _phoneController = TextEditingController(text: '+92 300 0000000');
  final TextEditingController _locationController = TextEditingController(text: 'Islamabad, Pakistan');

  bool _isEditing = false;

  @override
  void dispose() {
    for (var controller in [_nameController, _bioController, _emailController, _phoneController, _locationController]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 60),
            
            // --- PROFILE HEADER ---
            _buildProfileHeader(),
            
            const SizedBox(height: 25),

            // --- USER STATS SECTION ---
            _buildStatsRow(),

            const SizedBox(height: 30),

            // --- CONTACT INFORMATION CARD ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GlassCard(
                borderRadius: 24,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Personal Information", 
                        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 20),
                      _buildProfileItem(Icons.email_outlined, 'Email', _emailController.text),
                      const Divider(color: Colors.white10, height: 30),
                      _buildProfileItem(Icons.phone_android_outlined, 'Phone', _phoneController.text),
                      const Divider(color: Colors.white10, height: 30),
                      _buildProfileItem(Icons.location_on_outlined, 'Location', _locationController.text),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- ACCOUNT SETTINGS CARD ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GlassCard(
                borderRadius: 24,
                child: Column(
                  children: [
                    _buildSettingsTile(Icons.shield_outlined, "Privacy Settings"),
                    _buildSettingsTile(Icons.notifications_none_outlined, "Notifications"),
                    _buildSettingsTile(Icons.help_outline, "Help & Support"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // --- LOGOUT BUTTON ---
            TextButton.icon(
              onPressed: () {
                // Add Logout Logic
              },
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              label: Text("Logout", 
                style: GoogleFonts.poppins(color: Colors.redAccent, fontWeight: FontWeight.w500)),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS ---

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accentBlue1.withOpacity(0.5), width: 2),
                ),
              ),
              const CircleAvatar(
                radius: 58,
                backgroundImage: AssetImage('assets/images/icons/user.png'),
                backgroundColor: Colors.white10,
              ),
              Positioned(
                bottom: 0,
                right: 5,
                child: GestureDetector(
                  onTap: () => setState(() => _isEditing = !_isEditing),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: AppColors.accentBlue1, shape: BoxShape.circle),
                    child: Icon(_isEditing ? Icons.check : Icons.edit, color: Colors.white, size: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        if (_isEditing)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                _buildInlineInput(_nameController, 22, true),
                _buildInlineInput(_bioController, 14, false),
              ],
            ),
          )
        else
          Column(
            children: [
              Text(_nameController.text,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text(_bioController.text,
                  style: GoogleFonts.poppins(color: Colors.white60, fontSize: 14)),
            ],
          ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem("12", "Bikes"),
        _buildStatItem("6", "Slots"),
        _buildStatItem("4.6K", "Earnings"),
      ],
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(count, style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: GoogleFonts.poppins(color: Colors.white54, fontSize: 12)),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title) {
    return ListTile(
      onTap: () {
        // Action here
      },
      // This ensures the splash/hover effect matches the card's roundness
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      leading: Icon(icon, color: Colors.white70, size: 22),
      title: Text(
        title,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24, size: 20),
      
      // Customizing the hover/press feedback
      hoverColor: Colors.white.withOpacity(0.05),
      splashColor: AppColors.accentBlue1.withOpacity(0.1),
    );
  }

  // Reuse your existing _buildInlineInput and _buildProfileItem here...
  Widget _buildInlineInput(TextEditingController controller, double fontSize, bool isBold) {
     return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
      decoration: const InputDecoration(border: InputBorder.none, isDense: true),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accentBlue1, size: 22),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: GoogleFonts.poppins(color: Colors.white54, fontSize: 11)),
            Text(value, style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
          ],
        ),
      ],
    );
  }
}