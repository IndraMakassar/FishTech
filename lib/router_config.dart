import 'dart:async';

import 'package:fishtech/bloc/auth/auth_bloc.dart';
import 'package:fishtech/model/pond_card_model.dart';
import 'package:fishtech/view/pages/pages.dart';
import 'package:fishtech/view/pages/pond_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fishtech/bloc/notification/notif_bloc.dart';
import 'injection_container.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>();

final GoRouter routerConfig = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigationKey,
  refreshListenable: GoRouterRefreshStream(getIt<AuthBloc>().stream),
  redirect: (context, state) {
    final authBloc = getIt<AuthBloc>();
    final authState = authBloc.state;

    final isAuthenticated = authState is AuthAuthenticated;
    final isUnauthenticated =
        authState is AuthUnauthenticated || authState is AuthFailure;
    final isLoading = authState is AuthLoading || authState is AuthInitial;

    final isLoggingIn = state.matchedLocation.contains('login') ||
        state.matchedLocation.contains('register');

    if (isAuthenticated && isLoggingIn) {
      return '/home';
    }

    if (isUnauthenticated && !isLoggingIn) {
      return '/login';
    }

    if (isLoading) {
      return null;
    }

    return null;
  },
  routes: <RouteBase>[
    GoRoute(path: '/', redirect: (_, __) => '/login'),
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
      builder: (context, state) {
        final pond = state.extra as PondCardModel;
        return DetailKolam(pond: pond);
      },
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
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<NotifBloc>(), // Use the registered bloc
        child: const NotificationScreen(),
      ),
    ),
    GoRoute(
      path: '/scan',
      builder: (context, state) => const ScanQr(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const PondSettingsScreen(),
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

class GoRouterRefreshStream extends ChangeNotifier {
  final Stream<dynamic> _stream;
  late final StreamSubscription _subscription;

  GoRouterRefreshStream(this._stream) {
    _subscription = _stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
