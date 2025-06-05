part of '../_test.dart';

void runLogoutTests() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAuthRepository mockAuthRepository;
  late MockGoRouter mockGoRouter;
  late AuthBloc authBloc;

  final testSession = supabase.Session(
    accessToken: 'fake_token',
    tokenType: '',
    expiresIn: 0,
    refreshToken: '',
    user: (supabase.User.fromJson({
      'id': 'test_id',
      'email': 'test@example.com',
      'created_at': DateTime.now().toIso8601String(),
      'user_metadata': {'Display name': 'Test User'},
      'aud': 'authenticated',
      'role': 'authenticated',
    }))!,
  );

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockGoRouter = MockGoRouter();

    when(() => mockAuthRepository.checkSession())
        .thenAnswer((_) => Future.value(testSession));
    when(() => mockAuthRepository.onAuthStateChange)
        .thenAnswer((_) => Stream.value(
              AuthStateChange(supabase.AuthChangeEvent.signedIn, testSession),
            ));

    authBloc = AuthBloc(mockAuthRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: InheritedGoRouter(
        goRouter: mockGoRouter,
        child: BlocProvider.value(
          value: authBloc,
          child: const ProfileScreen(),
        ),
      ),
    );
  }

  group('Logout Tests', () {
    testWidgets('should show logout button in authenticated state',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Logout'), findsOneWidget);
      expect(find.byType(CustomButton), findsWidgets);
    });

    testWidgets('should call signOut when logout button is pressed',
        (WidgetTester tester) async {
      // Setup
      when(() => mockAuthRepository.signOut()).thenAnswer((_) async {});
      when(() => mockGoRouter.go(any())).thenReturn(null);

      // Initialize bloc with authenticated state
      authBloc.emit(AuthAuthenticated(testSession));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Find and verify the button exists
      final logoutButton = find.widgetWithText(CustomButton, 'Logout');
      expect(logoutButton, findsOneWidget);

      // Perform the action
      await tester.tap(logoutButton);
      await tester.pump(); // Process tap
      await tester.pumpAndSettle(); // Wait for all animations and async work

      // Verify the logout call
      verify(() => mockAuthRepository.signOut()).called(1);

      // Verify navigation (if expected)
      verify(() => mockGoRouter.go('/login')).called(1);
    });

    testWidgets('should show error message when logout fails',
        (WidgetTester tester) async {
      when(() => mockAuthRepository.signOut())
          .thenThrow(supabase.AuthException('Failed to logout'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Logout'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Failed to logout'), findsOneWidget);
    });

    testWidgets('should verify email field is read-only',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final emailField = find.byWidgetPredicate(
        (widget) => widget is FormFieldWidget && widget.labelText == 'Email',
      );

      expect(emailField, findsOneWidget);
      expect(
        tester.widget<FormFieldWidget>(emailField).isReadOnly,
        true
      );
    });
  });
}