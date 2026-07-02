import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'features/splash/splash.dart';
import 'features/auth/auth.dart';
import 'features/auth/data/auth_service.dart';
import 'shared/navigation/main_navigation_shell.dart';

class FinLearnApp extends StatefulWidget {
  const FinLearnApp({super.key});

  @override
  State<FinLearnApp> createState() => _FinLearnAppState();
}

class _FinLearnAppState extends State<FinLearnApp> {
  AppState _appState = AppState.splash;
  String _uid = '';

  @override
  void initState() {
    super.initState();
    _configureOrientations();

    AuthService().authStateChanges.listen((user) {
      if (mounted) {
        setState(() {
          _uid = user?.uid ?? '';
          _appState = user != null ? AppState.main : AppState.auth;
        });
      }
    });
  }

  void _configureOrientations() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _updateSystemUI(bool isDark) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDark ? AppColors.darkBackground : AppColors.backgroundSecondary,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }

  void _handleSplashComplete() {
    final user = AuthService().currentUser;
    setState(() {
      _uid = user?.uid ?? '';
      _appState = user != null ? AppState.main : AppState.auth;
    });
  }

  void _handleAuthComplete() {
    setState(() => _appState = AppState.main);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          final platformBrightness = MediaQuery.platformBrightnessOf(context);
          final isSystemDark = platformBrightness == Brightness.dark;
          
          context.read<ThemeCubit>().updateSystemTheme(isSystemDark);
          
          final isDark = mode == ThemeMode.dark || (mode == ThemeMode.system && isSystemDark);
          _updateSystemUI(isDark);

          return MaterialApp(
            title: 'FinLearn Pro',
            debugShowCheckedModeBanner: false,
            themeMode: mode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: _buildCurrentScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_appState) {
      case AppState.splash:
        return SplashScreen(
          key: const ValueKey('splash'),
          onComplete: _handleSplashComplete,
        );
      case AppState.auth:
        return AuthFlowCoordinator(
          key: const ValueKey('auth'),
          onAuthComplete: _handleAuthComplete,
          showWelcome: true,
        );
      case AppState.main:
        return MainNavigationShell(
          key: ValueKey('main_$_uid'),
          firebaseUid: _uid,
        );
    }
  }
}

enum AppState { splash, auth, main }
