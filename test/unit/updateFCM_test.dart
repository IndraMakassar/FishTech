part of '../_test.dart';

void runUpdateFCMTests() {
  group('FCM Token Update Tests', () {
    late MockAuthRepository mockAuthRepository;
    late MockFirebaseMessaging mockFirebaseMessaging;
    late MockSharedPreferences mockSharedPreferences;
    late AuthBloc authBloc;

    final testUser = (supabase.User.fromJson({
      'id': 'test_id',
      'email': 'test@example.com',
      'created_at': DateTime.now().toIso8601String(),
      'user_metadata': {
        'Display name': 'Test User',
      },
      'aud': 'authenticated',
      'role': 'authenticated',
    }))!;

    final testSession = supabase.Session(
      accessToken: 'fake_token',
      tokenType: 'bearer',
      expiresIn: 3600,
      refreshToken: 'fake_refresh_token',
      user: testUser,
    );

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      mockFirebaseMessaging = MockFirebaseMessaging();
      mockSharedPreferences = MockSharedPreferences();
      authBloc = AuthBloc(mockAuthRepository);

      // Set up SharedPreferences mock
      SharedPreferences.setMockInitialValues({});
    });

    tearDown(() {
      authBloc.close();
    });

    test('should update FCM token when new token is different from stored token',
        () async {
      // Arrange
      const newToken = 'new_fcm_token';
      const oldToken = 'old_fcm_token';

      // Mock Firebase token
      when(() => mockFirebaseMessaging.getToken())
          .thenAnswer((_) async => newToken);

      // Mock SharedPreferences
      when(() => mockSharedPreferences.getString('fcm_token'))
          .thenReturn(oldToken);
      when(() => mockSharedPreferences.setString('fcm_token', any()))
          .thenAnswer((_) async => true);

      // Mock Auth state
      when(() => mockAuthRepository.checkSession())
          .thenAnswer((_) async => testSession);
      when(() => mockAuthRepository.onAuthStateChange).thenAnswer(
        (_) => Stream.value(
          AuthStateChange(supabase.AuthChangeEvent.signedIn, testSession),
        ),
      );

      // Act
      authBloc.add(UserChangeToken(newToken: newToken));

      // Assert
      await expectLater(
        authBloc.stream,
        emitsInOrder([
          isA<AuthLoadingWhileAuthenticated>(),
          isA<AuthAuthenticated>(),
        ]),
      );

      verify(() => mockSharedPreferences.setString('fcm_token', newToken))
          .called(1);
    });

    test('should not update FCM token when tokens are identical', () async {
      // Arrange
      const existingToken = 'existing_fcm_token';

      // Mock Firebase token
      when(() => mockFirebaseMessaging.getToken())
          .thenAnswer((_) async => existingToken);

      // Mock SharedPreferences
      when(() => mockSharedPreferences.getString('fcm_token'))
          .thenReturn(existingToken);

      // Mock Auth state
      when(() => mockAuthRepository.checkSession())
          .thenAnswer((_) async => testSession);
      when(() => mockAuthRepository.onAuthStateChange).thenAnswer(
        (_) => Stream.value(
          AuthStateChange(supabase.AuthChangeEvent.signedIn, testSession),
        ),
      );

      // Act & Assert
      verifyNever(() => mockSharedPreferences.setString('fcm_token', any()));
      verifyNever(() => mockAuthRepository.changeToken(any()));
    });

    test('should handle error when updating FCM token', () async {
      // Arrange
      const newToken = 'new_fcm_token';

      when(() => mockAuthRepository.changeToken(any()))
          .thenThrow(Exception('Failed to update token'));

      when(() => mockAuthRepository.checkSession())
          .thenAnswer((_) async => testSession);
      when(() => mockAuthRepository.onAuthStateChange).thenAnswer(
        (_) => Stream.value(
          AuthStateChange(supabase.AuthChangeEvent.signedIn, testSession),
        ),
      );

      // Act
      authBloc.add(UserChangeToken(newToken: newToken));

      // Assert
      await expectLater(
        authBloc.stream,
        emitsInOrder([
          isA<AuthLoadingWhileAuthenticated>(),
          isA<AuthFailure>().having(
            (state) => state.message,
            'error message',
            'Failed to update token',
          ),
        ]),
      );
    });

    test('should not update FCM token when user is not authenticated', () async {
      // Arrange
      const newToken = 'new_fcm_token';

      // Mock unauthenticated state
      when(() => mockAuthRepository.checkSession())
          .thenAnswer((_) async => null);
      when(() => mockAuthRepository.onAuthStateChange).thenAnswer(
        (_) => Stream.value(
          AuthStateChange(supabase.AuthChangeEvent.signedOut, null),
        ),
      );

      // Act & Assert
      verifyNever(() => mockFirebaseMessaging.getToken());
      verifyNever(() => mockSharedPreferences.setString('fcm_token', any()));
      verifyNever(() => mockAuthRepository.changeToken(any()));
    });
  });
}