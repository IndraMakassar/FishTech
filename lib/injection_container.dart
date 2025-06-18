import 'package:fishtech/bloc/auth/auth_bloc.dart';
import 'package:fishtech/bloc/pond/pond_bloc.dart';
import 'package:fishtech/bloc/notification/notif_bloc.dart';
import 'package:fishtech/repository/auth_repository.dart';
import 'package:fishtech/repository/notif_repository.dart';
import 'package:fishtech/repository/pond_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);
  getIt.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  getIt.registerSingleton<FirebaseApp>(await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform));
  getIt.registerSingleton<FirebaseMessaging>(FirebaseMessaging.instance);

  getIt.registerLazySingleton(() => AuthRepository(getIt()));
  getIt.registerLazySingleton(() => PondRepository(supabase: getIt()));
  getIt.registerLazySingleton(() => NotifRepository(supabase: getIt()));

  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(getIt()));
  getIt.registerFactory(() => PondBloc(getIt()));
  getIt.registerFactory(() => NotifBloc(getIt()));
}