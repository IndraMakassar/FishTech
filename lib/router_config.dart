import 'package:fishtech/view/pages/detail_kolam_screen.dart';
import 'package:fishtech/view/pages/history_screen.dart';
import 'package:fishtech/view/pages/home_screen.dart';
import 'package:fishtech/view/pages/profile_screen.dart';
import 'package:fishtech/view/pages/register_screen.dart';
import 'package:fishtech/view/pages/login_screen.dart';
import 'package:fishtech/view/widgets/home_shell.dart';
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
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(
          navigationShell: child,
        );
      },
      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        // Statistic Branch
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/detail_kolam',
              builder: (context, state) => DetailKolam(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/history',
              builder: (context, state) => HistoryScreen(),
            )
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/profile',
              builder: (context, state) => ProfileScreen(),
            )
          ],
        ),
      ],
    ),
  ],
);
