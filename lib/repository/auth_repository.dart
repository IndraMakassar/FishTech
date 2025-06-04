import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        data: {
          'Display name': name,  // for email login users
          'name': name,          // for Google login users
          'full_name': name,     // also update full_name for consistency
        },
      ),
    );
    final AuthResponse res = await _supabase.auth.refreshSession();
    return res;
  }

  Future<Session?> checkSession() async {
    return _supabase.auth.currentSession;
  }

  Future<void> changeToken(String token) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      await _supabase
          .from('profiles')
          .upsert({
        'id': user.id,
        'fcm_token': token,
      });
    } catch (e) {
      print('Error in changeToken: $e');
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
  try {
    print('Starting Google Sign In process...');

    const webClientId = '247526764850-d5l6n1l27auhpkksku79lh3r44vh340a.apps.googleusercontent.com';
    const iosClientId = '247526764850-k0fd3ckqi4k93u012iq1juhg7m58rsvm.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );

    print('Attempting to show Google Sign In dialog...');
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      print('Sign in was canceled by user');
      return;
    }

    print('Successfully signed in with Google. Email: ${googleUser.email}');

    print('Getting Google auth tokens...');
    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    print('Access Token: ${accessToken?.substring(0, 20)}...'); // Only print first 20 chars for security
    print('ID Token: ${idToken?.substring(0, 20)}...'); // Only print first 20 chars for security

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    print('Attempting to sign in with Supabase...');
    await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    print('Successfully signed in with Supabase!');

  } catch (e, stackTrace) {
    print('Error during Google Sign In: $e');
    print('Stack trace: $stackTrace');
    rethrow; // Re-throw the error so it can be handled by the calling code
  }
}
}