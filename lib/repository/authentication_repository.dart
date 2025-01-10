import 'package:supabase_flutter/supabase_flutter.dart';


// TODO: add exception handling
class AuthenticationRepository {
  final SupabaseClient _supabase;

  AuthenticationRepository(this._supabase);

  Future<AuthResponse> signUpWithEmail(String email, String password) async {
    final AuthResponse res = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    return res;
  }

  Future<AuthResponse> signInWithEmail(String email, String password) async {
    final AuthResponse res = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return res;
  }

  Future<void> signOut() async {
      await _supabase.auth.signOut();
    }

}
