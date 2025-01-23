import 'package:fishtech/app_bloc_observer.dart';
import 'package:fishtech/bloc/auth/auth_bloc.dart';
import 'package:fishtech/const.dart';
import 'package:fishtech/injection_container.dart';
import 'package:fishtech/router_config.dart';
import 'package:fishtech/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SUPABASE_URL,
    anonKey: ANON_KEY,
  );

  await initializeDependencies();

  Bloc.observer = const AppBlocObserver();

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
      // darkTheme: materialTheme.dark(),
      // themeMode: ThemeMode.system,
      routerConfig: routerConfig,
    );
  }

  @override
  void initState() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (session != null) {
        context.read<AuthBloc>().add(UserCheckedLogIn(session));
        GoRouter.of(context).go('/home');
      } else {

      }
    });
    super.initState();
  }
}
