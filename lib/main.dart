import 'package:fishtech/router_config.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://tyumikqftrhxgcziakay.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR5dW1pa3FmdHJoeGdjemlha2F5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYyMjM1MDEsImV4cCI6MjA1MTc5OTUwMX0.-12NMKqL9KGkSg-8xlOVpowNf34dFnioZIofPqq7jjs',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: routerConfig,
    );
  }
}