import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fishtech/app_bloc_observer.dart';
import 'package:fishtech/bloc/auth/auth_bloc.dart';
import 'package:fishtech/const.dart';
import 'package:fishtech/injection_container.dart';
import 'package:fishtech/router_config.dart';
import 'package:fishtech/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Preserve splash screen and initialize widgets binding
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Supabase
  await Supabase.initialize(
    url: SUPABASE_URL,
    anonKey: ANON_KEY,
  );

  // Initialize dependencies
  await initializeDependencies();

  // Set up Bloc observer
  Bloc.observer = const AppBlocObserver();

  // Remove splash screen after app initialization
  FlutterNativeSplash.remove();

  // Run the app
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => getIt()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    const materialTheme = MaterialTheme(TextTheme());

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: materialTheme.light(),
      routerConfig: routerConfig,
    );
  }
}
