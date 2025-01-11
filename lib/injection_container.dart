import 'package:fishtech/bloc/auth/auth_bloc.dart';
import 'package:fishtech/repository/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async{
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);

  getIt.registerLazySingleton(() => AuthRepository(getIt()));
  
  getIt.registerFactory(() => AuthBloc(getIt()));
}