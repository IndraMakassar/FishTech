import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStateChange {
  final AuthChangeEvent event;
  final Session? session;

  AuthStateChange(this.event, this.session);
}

// TODO: add exception handling
class AuthRepository {
  final SupabaseClient _supabase;
  late final Stream<AuthStateChange> _authChanges =
  _supabase
      .auth
      .onAuthStateChange
      .map((e) => AuthStateChange(e.event, e.session))
      .asBroadcastStream();



  AuthRepository(this._supabase);

  Stream<AuthStateChange> get onAuthStateChange => _authChanges;

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

  Future<Session?> checkSession() async {
    return _supabase.auth.currentSession;
  }
}
