import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/auth_service.dart';
import '../../../social/data/repositories/social_repository.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Gradient
            Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2962FF), Color(0xFF00B4D8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.white,
                        ),
                      ),
                      const Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: 48), // Balance for the back button
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Color(0xFF2962FF),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user?.displayName ?? 'Prince Surani',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user?.email ?? 'prince.surani@example.com',
                    style: const TextStyle(fontSize: 14, color: AppColors.white70),
                  ),
                ],
              ),
            ),

            // Menu Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 12),
                    child: Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  _buildMenuOption(
                    title: 'Edit Username',
                    icon: Icons.person_outline_rounded,
                    color: AppColors.primary,
                    onTap: () => _showEditProfileDialog(context, user),
                  ),
                  _buildMenuOption(
                    title: 'Security & Password',
                    icon: Icons.security_rounded,
                    color: AppColors.oceanTeal,
                    onTap: () => _showSecurityDialog(context, user),
                  ),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 12),
                    child: Text(
                      'Preferences',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  _buildMenuOption(
                    title: 'Notifications',
                    icon: Icons.notifications_none_rounded,
                    color: AppColors.sunsetOrange,
                    onTap: () => _showNotificationsSheet(context),
                  ),
                  _buildMenuOption(
                    title: 'App Theme',
                    icon: Icons.dark_mode_outlined,
                    color: AppColors.electricBlue,
                    onTap: () => _showThemeSheet(context),
                  ),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 12),
                    child: Text(
                      'Support',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  _buildMenuOption(
                    title: 'Help Center',
                    icon: Icons.help_outline_rounded,
                    color: AppColors.neutralGray,
                    onTap: () => _showHelpCenter(context),
                  ),
                  _buildMenuOption(
                    title: 'About FinLearn Pro',
                    icon: Icons.info_outline_rounded,
                    color: AppColors.neutralGray,
                    onTap: () => _showAbout(context),
                  ),
                  const SizedBox(height: 32),
                  _buildMenuOption(
                    title: 'Log Out',
                    icon: Icons.logout_rounded,
                    color: AppColors.error,
                    isDestructive: true,
                    onTap: () async {
                      await AuthService().signOut();
                      if (context.mounted) {
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption({
    required String title,
    required IconData icon,
    required Color color,
    bool isDestructive = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDestructive ? AppColors.error : AppColors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textDisabled),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, User? user) {
    final controller = TextEditingController(text: user?.displayName ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Username'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () async {
              if (controller.text.trim().isNotEmpty && user != null) {
                await user.updateDisplayName(controller.text.trim());
                try {
                  await SocialRepository().updateProfile(user.uid, username: controller.text.trim());
                } catch (_) {}
                if (ctx.mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated. Please restart app to see changes.')),
                  );
                }
              }
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSecurityDialog(BuildContext context, User? user) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Security & Password'),
        content: Text('Send a password reset link to ${user?.email ?? 'your email'}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.oceanTeal),
            onPressed: () async {
              if (user?.email != null) {
                await FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email!);
                if (ctx.mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password reset email sent!')),
                  );
                }
              }
            },
            child: const Text('Send Reset Link', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showNotificationsSheet(BuildContext context) {
    bool pushEnabled = true;
    bool emailEnabled = false;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Notifications', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Push Notifications', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Alerts for daily challenges & trades.'),
                value: pushEnabled,
                activeThumbColor: AppColors.white,
                activeTrackColor: AppColors.sunsetOrange,
                onChanged: (val) => setState(() => pushEnabled = val),
              ),
              SwitchListTile(
                title: const Text('Email Summaries', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Weekly performance reports.'),
                value: emailEnabled,
                activeThumbColor: AppColors.white,
                activeTrackColor: AppColors.sunsetOrange,
                onChanged: (val) => setState(() => emailEnabled = val),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showThemeSheet(BuildContext context) {
    int selectedTheme = 0; // 0 = System, 1 = Light, 2 = Dark
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('App Theme', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('System Default', style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: selectedTheme == 0 ? const Icon(Icons.check_circle_rounded, color: AppColors.electricBlue) : const Icon(Icons.circle_outlined, color: AppColors.neutralGray),
                onTap: () => setState(() => selectedTheme = 0),
              ),
              ListTile(
                title: const Text('Light Mode', style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: selectedTheme == 1 ? const Icon(Icons.check_circle_rounded, color: AppColors.electricBlue) : const Icon(Icons.circle_outlined, color: AppColors.neutralGray),
                onTap: () => setState(() => selectedTheme = 1),
              ),
              ListTile(
                title: const Text('Dark Mode (Beta)', style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: selectedTheme == 2 ? const Icon(Icons.check_circle_rounded, color: AppColors.electricBlue) : const Icon(Icons.circle_outlined, color: AppColors.neutralGray),
                onTap: () => setState(() => selectedTheme = 2),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showHelpCenter(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Help Center'),
        content: const Text(
          'Need assistance? Our support team is here to help.\n\n'
          'Email: support@finlearnpro.com\n'
          'Phone: +1 (800) 555-0199',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'FinLearn Pro',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.candlestick_chart_rounded, size: 48, color: AppColors.primary),
      ),
      children: [
        const SizedBox(height: 16),
        const Text('The ultimate financial learning and trading simulation platform.'),
      ],
    );
  }
}
