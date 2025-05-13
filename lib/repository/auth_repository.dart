import 'package:supabase_flutter/supabase_flutter.dart';

// TODO: add exception handling
class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository(this._supabase);

  Future<AuthResponse> signUpWithEmail(
    String name,
    String email,
    String password,
  ) async {
    final AuthResponse res = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'Display name': name},
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

  Future<AuthResponse> changeName(String name) async {
    await _supabase.auth.updateUser(
      UserAttributes(
        data: {'Display name': name},
      ),
    );
    final AuthResponse res = await _supabase.auth.refreshSession();
    return res;
  }

  Future<AuthResponse> changeToken(String token) async {
    await _supabase.auth.updateUser(
      UserAttributes(
        data: {'Device token': token},
      ),
    );
    final AuthResponse res = await _supabase.auth.refreshSession();
    return res;
  }
}
