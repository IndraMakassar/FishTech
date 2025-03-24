import 'package:fishtech/view/pages/add_screen.dart';
import 'package:fishtech/view/pages/article_screen.dart';
import 'package:fishtech/view/pages/detail_kolam_screen.dart';
import 'package:fishtech/view/pages/home_screen.dart';
import 'package:fishtech/view/pages/profile_screen.dart';
import 'package:fishtech/view/pages/register_screen.dart';
import 'package:fishtech/view/pages/login_screen.dart';
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
      path: '/add',
      builder: (context, state) => const AddScreen(),
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
  ],
);
