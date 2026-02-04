
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_animations.dart';
import 'drawer_header.dart';
import 'drawer_menu_section.dart';
import 'drawer_quick_actions.dart';
import 'drawer_stats_card.dart';
import 'drawer_footer.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  static Future<T?> show<T>(BuildContext context) {
    HapticFeedback.mediumImpact();
    return Navigator.of(context).push<T>(
      _DrawerRoute<T>(
        builder: (context) => const AppDrawer(),
      ),
    );
  }

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> 
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation<double> _slideAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  // Scroll controller for the menu content
  final ScrollController _scrollController = ScrollController();

  // Track if user is dragging to close
  bool _isDragging = false;
  double _dragStartX = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.mediumDuration,
    );

    // Slide from left with a slight overshoot for polish
    _slideAnimation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.overshootCurve,
    ));

    // Fade in the content
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    // Subtle scale for depth
    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.entranceCurve,
    ));

    // Start the entrance animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _closeDrawer() async {
    HapticFeedback.lightImpact();
    await _controller.reverse();
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _handleDragStart(DragStartDetails details) {
    _isDragging = true;
    _dragStartX = details.localPosition.dx;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    final delta = details.localPosition.dx - _dragStartX;
    if (delta < 0) {
      // Dragging left - animate towards closed
      final progress = (-delta / 200).clamp(0.0, 1.0);
      _controller.value = 1.0 - progress;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!_isDragging) return;
    _isDragging = false;

    final velocity = details.primaryVelocity ?? 0;

    // If velocity is high enough or dragged past threshold, close
    if (velocity < -500 || _controller.value < 0.5) {
      _closeDrawer();
    } else {
      // Snap back open
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth * 0.85; // 85% of screen width
    final safeArea = MediaQuery.of(context).padding;

    return GestureDetector(
      onTap: _closeDrawer,
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              // Scrim overlay (no blur for performance)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.5 * _fadeAnimation.value),
                ),
              ),

              // The drawer itself
              Positioned(
                left: _slideAnimation.value * drawerWidth,
                top: 0,
                bottom: 0,
                width: drawerWidth,
                child: GestureDetector(
                  onTap: () {}, // Absorb taps on the drawer
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    alignment: Alignment.centerLeft,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildDrawerContent(
                        drawerWidth: drawerWidth,
                        safeArea: safeArea,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawerContent({
    required double drawerWidth,
    required EdgeInsets safeArea,
  }) {
    return Material(
      color: const Color(0xFF1A1A2E),
      child: Container(
        decoration: BoxDecoration(
          // Solid dark background for performance
          color: const Color(0xFF1A1A2E),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(5, 0),
            ),
          ],
          // Subtle right border
          border: const Border(
            right: BorderSide(
              color: Color(0xFF2A2A3E),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
        child: Column(
          children: [
            // Drawer Header with Profile
            AppDrawerHeader(
              onClose: _closeDrawer,
            ),

            // Scrollable Content
            Expanded(
              child: ScrollConfiguration(
                behavior: _NoGlowScrollBehavior(),
                child: ListView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    const SizedBox(height: 8),

                    // Quick Stats Dashboard
                    const DrawerStatsCard(),

                    const SizedBox(height: 24),

                    // Quick Actions
                    const DrawerQuickActions(),

                    const SizedBox(height: 24),

                    // Main Menu Sections
                    DrawerMenuSection(
                      onItemTap: _closeDrawer,
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Footer with version and legal
            const DrawerFooter(),
          ],
        ),
      ),
      ),
    );
  }
}

class _DrawerRoute<T> extends PopupRoute<T> {
  _DrawerRoute({
    required this.builder,
  });

  final WidgetBuilder builder;

  @override
  Color? get barrierColor => null; // We handle scrim ourselves

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Close drawer';

  @override
  Duration get transitionDuration => Duration.zero; // Widget handles animation

  @override
  bool get maintainState => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }
}

class _NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
