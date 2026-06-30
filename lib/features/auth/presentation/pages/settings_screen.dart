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
                  _MenuOptionCard(
                    title: 'Edit Username',
                    icon: Icons.person_outline_rounded,
                    color: AppColors.primary,
                    onTap: () => _showEditProfileDialog(context, user),
                  ),
                  _MenuOptionCard(
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
                  _MenuOptionCard(
                    title: 'Notifications',
                    icon: Icons.notifications_none_rounded,
                    color: AppColors.sunsetOrange,
                    onTap: () => _showNotificationsSheet(context),
                  ),
                  _MenuOptionCard(
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
                  _MenuOptionCard(
                    title: 'Help Center',
                    icon: Icons.help_outline_rounded,
                    color: AppColors.neutralGray,
                    onTap: () => _showHelpCenter(context),
                  ),
                  _MenuOptionCard(
                    title: 'About FinLearn Pro',
                    icon: Icons.info_outline_rounded,
                    color: AppColors.neutralGray,
                    onTap: () => _showAbout(context),
                  ),
                  const SizedBox(height: 32),
                  _MenuOptionCard(
                    title: 'Log Out',
                    icon: Icons.logout_rounded,
                    color: AppColors.error,
                    isDestructive: true,
                    onTap: () => _showLogoutConfirmation(context),
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



  void _showEditProfileDialog(BuildContext context, User? user) {
    final controller = TextEditingController(text: user?.displayName ?? '');
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_outline_rounded, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Edit Username',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose a unique username to represent yourself on FinLearn Pro social leaderboards.',
                style: TextStyle(color: AppColors.textSecondary, height: 1.4, fontSize: 13),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                enabled: !isLoading,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter new username',
                  prefixIcon: const Icon(Icons.alternate_email_rounded, size: 18),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary, width: 2),
                  ),
                ),
              ),
              if (isLoading) ...[
                const SizedBox(height: 12),
                const Row(
                  children: [
                    SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                    SizedBox(width: 10),
                    Text('Checking availability...', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ]
            ],
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: isLoading
                  ? null
                  : () async {
                      final newName = controller.text.trim();
                      if (newName.isEmpty || user == null) return;

                      if (newName == user.displayName) {
                        Navigator.pop(ctx);
                        return;
                      }

                      setDialogState(() => isLoading = true);

                      // Check username availability
                      final isAvailable = await SocialRepository().checkUsernameAvailable(newName);
                      if (!isAvailable) {
                        setDialogState(() => isLoading = false);
                        if (ctx.mounted) {
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            const SnackBar(
                              content: Text('Username is already taken. Please choose another.'),
                              backgroundColor: AppColors.error,
                            ),
                          );
                        }
                        return;
                      }

                      try {
                        await user.updateDisplayName(newName);
                        await SocialRepository().updateProfile(user.uid, username: newName);
                        if (ctx.mounted) {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Profile updated successfully!'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        }
                      } catch (e) {
                        setDialogState(() => isLoading = false);
                        if (ctx.mounted) {
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            SnackBar(
                              content: Text('Failed to update profile: $e'),
                              backgroundColor: AppColors.error,
                            ),
                          );
                        }
                      }
                    },
              child: const Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void _showSecurityDialog(BuildContext context, User? user) {
    bool isSending = false;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.oceanTeal.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.security_rounded, color: AppColors.oceanTeal, size: 24),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Security & Password',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Account Security',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 8),
              Text(
                'A secure reset link will be sent to your registered email address:\n${user?.email ?? 'your email'}.',
                style: const TextStyle(color: AppColors.textSecondary, height: 1.4, fontSize: 13),
              ),
              if (isSending) ...[
                const SizedBox(height: 16),
                const Row(
                  children: [
                    SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.oceanTeal)),
                    SizedBox(width: 10),
                    Text('Sending password reset link...', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: isSending ? null : () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.oceanTeal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: isSending
                  ? null
                  : () async {
                      if (user?.email != null) {
                        setDialogState(() => isSending = true);
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email!);
                          if (ctx.mounted) {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Password reset email sent!'),
                                backgroundColor: AppColors.oceanTeal,
                              ),
                            );
                          }
                        } catch (e) {
                          setDialogState(() => isSending = false);
                          if (ctx.mounted) {
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              SnackBar(
                                content: Text('Failed to send reset email: $e'),
                                backgroundColor: AppColors.error,
                              ),
                            );
                          }
                        }
                      }
                    },
              child: const Text('Send Reset Link', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.logout_rounded, color: AppColors.error, size: 24),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Log Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to log out of FinLearn Pro? You will need to sign back in to access your virtual trading account.',
          style: TextStyle(height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              await AuthService().signOut();
              if (context.mounted) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

class _MenuOptionCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool isDestructive;
  final VoidCallback? onTap;

  const _MenuOptionCard({
    required this.title,
    required this.icon,
    required this.color,
    this.isDestructive = false,
    this.onTap,
  });

  @override
  State<_MenuOptionCard> createState() => _MenuOptionCardState();
}

class _MenuOptionCardState extends State<_MenuOptionCard> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animController.forward(),
      onTapUp: (_) {
        _animController.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _animController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: widget.color.withValues(alpha: 0.15)),
                ),
                child: Icon(widget.icon, color: widget.color, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: widget.isDestructive ? AppColors.error : AppColors.textPrimary,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}
