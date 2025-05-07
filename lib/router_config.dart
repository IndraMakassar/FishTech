import 'package:fishtech/view/pages/statistics_screen.dart';
import 'package:fishtech/view/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fishtech/view/pages/settings_pond_screen.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>();

final GoRouter routerConfig = GoRouter(
  initialLocation: '/statistics',
  navigatorKey: _rootNavigationKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/addPond',
      builder: (context, state) => const AddPond(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => const DetailKolam(),
    ),
    GoRoute(
      path: '/article',
      builder: (context, state) => const ArticlePage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/notification',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/scan',
      builder: (context, state) => const ScanQr(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingspondScreen(),
    ),
    GoRoute(
      path: '/addmachine',
      builder: (context, state) => const AddMachineScreen(),
    ),
    GoRoute(
      path: '/statistics',
      builder: (context, state) => const StatisticsScreen(),
    ),
  
  ],
);
