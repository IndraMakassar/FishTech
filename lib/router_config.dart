import 'package:fishtech/view/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>();

final GoRouter routerConfig = GoRouter(
  initialLocation: '/login',
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
      builder: (context, state) => DetailKolam(),
    ),
    GoRoute(
      path: '/article',
      builder: (context, state) => const ArticlePage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: '/notification',
      builder: (context, state) => NotificationScreen(),
    ),
    GoRoute(
      path: '/scan',
      builder: (context, state) => const ScanQr(),
    ),
  ],
);
