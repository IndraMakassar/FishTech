part of '../_test.dart';

void runProfileTests() {
  group('Profile Data Tests', () {
    late MockAuthRepository mockAuthRepository;
    late AuthBloc authBloc;

    final testUser = (supabase.User.fromJson({
      'id': 'test_id',
      'email': 'test@example.com',
      'created_at': DateTime.now().toIso8601String(),
      'user_metadata': {
        'Display name': 'Test User',
        'picture': 'https://example.com/avatar.jpg'
      },
      'aud': 'authenticated',
      'role': 'authenticated',
    }))!; // Add the non-null assertion operator here

    final testSession = supabase.Session(
      accessToken: 'fake_token',
      tokenType: 'bearer',
      expiresIn: 3600,
      refreshToken: 'fake_refresh_token',
      user: testUser,
    );

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      authBloc = AuthBloc(mockAuthRepository);
    });

    tearDown(() {
      authBloc.close();
    });

    test('should get user data from session', () {
      // Arrange
      when(() => mockAuthRepository.checkSession())
          .thenAnswer((_) async => testSession);
      when(() => mockAuthRepository.onAuthStateChange).thenAnswer(
        (_) => Stream.value(
          AuthStateChange(supabase.AuthChangeEvent.signedIn, testSession),
        ),
      );

      // Act & Assert
      expect(testSession.user.email, equals('test@example.com'));
      expect(testSession.user.userMetadata?['Display name'], equals('Test User'));
      expect(testSession.user.userMetadata?['picture'],
             equals('https://example.com/avatar.jpg'));
    });

    test('should handle null user metadata', () {
      // Arrange
      final userWithoutMetadata = (supabase.User.fromJson({
        'id': 'test_id',
        'email': 'test@example.com',
        'created_at': DateTime.now().toIso8601String(),
        'user_metadata': null,
        'aud': 'authenticated',
        'role': 'authenticated',
      }))!; // Add non-null assertion operator here

      final sessionWithoutMetadata = supabase.Session(
        accessToken: 'fake_token',
        tokenType: 'bearer',
        expiresIn: 3600,
        refreshToken: 'fake_refresh_token',
        user: userWithoutMetadata,
      );

      when(() => mockAuthRepository.checkSession())
          .thenAnswer((_) async => sessionWithoutMetadata);
      when(() => mockAuthRepository.onAuthStateChange).thenAnswer(
        (_) => Stream.value(
          AuthStateChange(supabase.AuthChangeEvent.signedIn, sessionWithoutMetadata),
        ),
      );

      // Act & Assert
      expect(sessionWithoutMetadata.user.email, equals('test@example.com'));
      expect(sessionWithoutMetadata.user.userMetadata, isNull);
    });
  });
}