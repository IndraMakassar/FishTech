import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fishtech/app_bloc_observer.dart';
import 'package:fishtech/bloc/auth/auth_bloc.dart';
import 'package:fishtech/bloc/notification/notif_bloc.dart';
import 'package:fishtech/bloc/pond/pond_bloc.dart';
import 'package:fishtech/const.dart';
import 'package:fishtech/firebase_options.dart';
import 'package:fishtech/injection_container.dart';
import 'package:fishtech/router_config.dart';
import 'package:fishtech/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final firebaseAppFuture = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPrefsFuture = SharedPreferences.getInstance();

  final results = await Future.wait([firebaseAppFuture, sharedPrefsFuture]);

  final firebaseApp = results[0] as FirebaseApp;
  final prefs = results[1] as SharedPreferences;

  getIt.registerSingleton<FirebaseApp>(firebaseApp);
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerSingleton<FirebaseMessaging>(FirebaseMessaging.instance);

  await Supabase.initialize(
    url: SUPABASE_URL,
    anonKey: ANON_KEY,
  );

  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);

  initializeDependencies();

  final firebaseMessaging = getIt<FirebaseMessaging>();

  await firebaseMessaging.setAutoInitEnabled(true);
  await firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  Bloc.observer = const AppBlocObserver();

  FlutterNativeSplash.remove();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => getIt()),
        BlocProvider<PondBloc>(create: (context) => getIt()),
        BlocProvider<NotifBloc>(create: (context)=> getIt()),
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
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    const materialTheme = MaterialTheme(TextTheme());

    return MaterialApp.router(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      // Add this line
      debugShowCheckedModeBanner: false,
      theme: materialTheme.light(),
      routerConfig: routerConfig,
    );
  }

  @override
  void initState() {
    super.initState();
    setupFirebaseMessaging();
    getIt<FirebaseMessaging>().onTokenRefresh.listen((newToken) async {
      final session = getIt<SupabaseClient>().auth.currentSession;
      final prefs = getIt<SharedPreferences>();
      if (session != null) {
        context.read<AuthBloc>().add(UserChangeToken(newToken: newToken));
        await prefs.setString('fcm_token', newToken);
      }
    });
  }

  void setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text('${notification.title} ${notification.body}'),
          ),
        );
      }
    });
  }
}
