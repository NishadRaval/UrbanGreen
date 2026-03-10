import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import Screens (Placeholders for now)
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/signup_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/garden/garden_screen.dart';
import '../../screens/marketplace/marketplace_screen.dart';
import '../../screens/community/tips_feed_screen.dart';
import '../../screens/plant_scan/plant_scan_screen.dart';
import '../../widgets/app_bottom_navbar.dart';
import '../../providers/auth_provider.dart';
import '../../services/auth_service.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoading = authState.isLoading;
      final isAuthenticated = authState.value != null;

      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToSignup = state.matchedLocation == '/signup';

      if (isLoading) return null;

      if (!isAuthenticated && !isGoingToLogin && !isGoingToSignup) {
        return '/login';
      }

      if (isAuthenticated && (isGoingToLogin || isGoingToSignup)) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      // App Shell (Bottom Navigation)
      ShellRoute(
        builder: (context, state, child) {
          return AppBottomNavbar(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/garden',
            builder: (context, state) => const GardenScreen(),
          ),
          GoRoute(
            path: '/scan',
            builder: (context, state) => const PlantScanScreen(),
          ),
          GoRoute(
            path: '/marketplace',
            builder: (context, state) => const MarketplaceScreen(),
          ),
          GoRoute(
            path: '/community',
            builder: (context, state) => const TipsFeedScreen(),
          ),
        ],
      )
    ],
  );
});
