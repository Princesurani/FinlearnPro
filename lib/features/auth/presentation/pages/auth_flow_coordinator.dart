import 'package:flutter/material.dart';
import '../../../../core/theme/app_animations.dart';
import 'welcome_screen.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class AuthFlowCoordinator extends StatefulWidget {
  const AuthFlowCoordinator({
    super.key,
    required this.onAuthComplete,
    this.showWelcome = true,
  });

  final VoidCallback onAuthComplete;

  final bool showWelcome;

  @override
  State<AuthFlowCoordinator> createState() => _AuthFlowCoordinatorState();
}

class _AuthFlowCoordinatorState extends State<AuthFlowCoordinator> {
  late AuthFlowPage _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.showWelcome
        ? AuthFlowPage.welcome
        : AuthFlowPage.signIn;
  }

  @override
  void didUpdateWidget(AuthFlowCoordinator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showWelcome != oldWidget.showWelcome) {
      setState(() {
        _currentPage = widget.showWelcome
            ? AuthFlowPage.welcome
            : AuthFlowPage.signIn;
      });
    }
  }

  void _navigateTo(AuthFlowPage page) {
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        // Welcome/Onboarding Page
        if (_currentPage.index >= AuthFlowPage.welcome.index)
          _FadeTransitionPage(
            key: const ValueKey('welcome'),
            child: WelcomeScreen(
              onComplete: () => _navigateTo(AuthFlowPage.signIn),
            ),
          ),

        // Sign In Page
        if (_currentPage.index >= AuthFlowPage.signIn.index)
          _SlideTransitionPage(
            key: const ValueKey('signIn'),
            child: SignInScreen(
              onSignInSuccess: widget.onAuthComplete,
              onNavigateToSignUp: () => _navigateTo(AuthFlowPage.signUp),
              onForgotPassword: () {
                // TODO: Navigate to forgot password
              },
            ),
          ),

        // Sign Up Page
        if (_currentPage == AuthFlowPage.signUp)
          _SlideTransitionPage(
            key: const ValueKey('signUp'),
            child: SignUpScreen(
              onSignUpSuccess: widget.onAuthComplete,
              onNavigateToSignIn: () => _navigateTo(AuthFlowPage.signIn),
            ),
          ),
      ],
      onDidRemovePage: (page) {
        if (page.key == const ValueKey('signUp')) {
          _navigateTo(AuthFlowPage.signIn);
        } else if (page.key == const ValueKey('signIn')) {
          _navigateTo(AuthFlowPage.welcome);
        }
      },
    );
  }
}

enum AuthFlowPage { welcome, signIn, signUp }

class _FadeTransitionPage<T> extends Page<T> {
  const _FadeTransitionPage({required this.child, super.key});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: AppAnimations.mediumDuration,
    );
  }
}

class _SlideTransitionPage<T> extends Page<T> {
  const _SlideTransitionPage({required this.child, super.key});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation =
            Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );

        final fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: const Interval(0.0, 0.5),
        );

        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(opacity: fadeAnimation, child: child),
        );
      },
      transitionDuration: AppAnimations.pageTransitionDuration,
    );
  }
}
