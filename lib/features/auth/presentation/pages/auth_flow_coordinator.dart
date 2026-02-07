import 'package:flutter/material.dart';

import '../../../../core/theme/app_animations.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';
import 'welcome_screen.dart';
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
  late _AuthPage _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage =
        widget.showWelcome ? _AuthPage.welcome : _AuthPage.signIn;
  }

  void _navigateTo(_AuthPage page) {
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: _buildPages(),
      onDidRemovePage: (_) {
        if (_currentPage == _AuthPage.signUp) {
          setState(() => _currentPage = _AuthPage.signIn);
        } else if (_currentPage == _AuthPage.signIn && widget.showWelcome) {
          setState(() => _currentPage = _AuthPage.welcome);
        }
      },
    );
  }

  List<Page<dynamic>> _buildPages() {
    return [
      if (widget.showWelcome)
        _FadeSlideTransitionPage(
          key: const ValueKey('welcome'),
          child: WelcomeScreen(
            onComplete: () => _navigateTo(_AuthPage.signIn),
            showSkipButton: true,
          ),
        ),
      if (_currentPage == _AuthPage.signIn ||
          _currentPage == _AuthPage.signUp)
        _FadeSlideTransitionPage(
          key: const ValueKey('signIn'),
          child: SignInScreen(
            onSignInSuccess: widget.onAuthComplete,
            onNavigateToSignUp: () => _navigateTo(_AuthPage.signUp),
            onForgotPassword: () {
            },
          ),
        ),
      if (_currentPage == _AuthPage.signUp)
        _FadeSlideTransitionPage(
          key: const ValueKey('signUp'),
          child: SignUpScreen(
            onSignUpSuccess: widget.onAuthComplete,
            onNavigateToSignIn: () => _navigateTo(_AuthPage.signIn),
          ),
        ),
    ];
  }
}
enum _AuthPage { welcome, signIn, signUp }

class _FadeSlideTransitionPage extends Page<void> {
  const _FadeSlideTransitionPage({
    required super.key,
    required this.child,
  });

  final Widget child;

  @override
  Route<void> createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      transitionDuration: AppAnimations.pageTransitionDuration,
      reverseTransitionDuration: AppAnimations.pageTransitionDuration,
      pageBuilder: (_, animation, secondaryAnimation) => child,
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        final fadeTween = Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOut));
        final slideTween = Tween<Offset>(
          begin: const Offset(0.0, 0.04),
          end: Offset.zero,
        ).chain(CurveTween(curve: AppAnimations.entranceCurve));

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: SlideTransition(
            position: animation.drive(slideTween),
            child: child,
          ),
        );
      },
    );
  }
}
