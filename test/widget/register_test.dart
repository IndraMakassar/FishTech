part of'../_test.dart';


void runRegisterTests(){
  TestWidgetsFlutterBinding.ensureInitialized();

  final binding = TestWidgetsFlutterBinding.instance;
  binding.window.physicalSizeTestValue = const Size(1920, 1080);
  binding.window.devicePixelRatioTestValue = 1.0;

  late MockAuthRepository mockAuthRepository;
  late MockGoRouter mockGoRouter;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockGoRouter = MockGoRouter();

    when(() => mockAuthRepository.checkSession())
        .thenAnswer((_) => Future.value(null));

    when(() => mockAuthRepository.onAuthStateChange)
        .thenAnswer((_) => const Stream.empty());
  });


  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: InheritedGoRouter(
        goRouter: mockGoRouter,
        child: BlocProvider(
          create: (context) => AuthBloc(mockAuthRepository),
          child: const RegisterScreen(),
        ),
      ),
    );
  }

  group('RegisterScreen Widget Tests', () {
    testWidgets('should show all required fields', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify all form fields are present
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
      expect(find.text('Register'), findsOneWidget);
      expect(find.text('Continue with Google'), findsOneWidget);
    });

    testWidgets('should show error when submitting empty form',
            (WidgetTester tester) async {
          await tester.pumpWidget(createWidgetUnderTest());

          // Tap register button without filling any fields
          await tester.tap(find.text('Register'));
          await tester.pump();

          // Verify error messages
          expect(find.text('Please enter your name'), findsOneWidget);
          expect(find.text('Please enter your Email'), findsOneWidget);
          expect(find.text('Please enter your password'), findsOneWidget);
          expect(find.text('Please reenter your password'), findsOneWidget);
        });

    testWidgets('should show error for invalid email format',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Add initial pump

      // Enter invalid email
      await tester.enterText(
          find.byType(TextFormField).at(1), 'invalidemail');
      await tester.pump(); // Pump after entering text

      // Tap register button
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle(); // Use pumpAndSettle to complete animations

      // Verify error message
      expect(find.text('Your email format is not valid'), findsOneWidget);
    });

    testWidgets('should show error when passwords do not match',
            (WidgetTester tester) async {
          await tester.pumpWidget(createWidgetUnderTest());

          // Enter different passwords
          await tester.enterText(
              find.byType(TextFormField).at(2), 'password123');
          await tester.enterText(
              find.byType(TextFormField).at(3), 'password456');

          // Tap register button
          await tester.tap(find.text('Register'));
          await tester.pump();

          // Verify error message
          expect(find.text('Passwords do not match'), findsOneWidget);
        });

    testWidgets('should show error for short password',
            (WidgetTester tester) async {
          await tester.pumpWidget(createWidgetUnderTest());

          // Enter short password
          await tester.enterText(
              find.byType(TextFormField).at(2), '12345');

          // Tap register button
          await tester.tap(find.text('Register'));
          await tester.pump();

          // Verify error message
          expect(find.text('Password must be at least 6 characters'), findsOneWidget);
        });

    testWidgets('should call register when form is valid',
            (WidgetTester tester) async {
          // Setup success response
          when(() => mockAuthRepository.signUpWithEmail(any(), any(), any()))
              .thenAnswer((_) async => supabase.AuthResponse(
            session: supabase.Session(
              accessToken: 'fake_token',
              tokenType: '',
              expiresIn: 0,
              refreshToken: '',
              user: (supabase.User.fromJson({
                'id': 'test_id',
                'email': 'test@example.com',
                'created_at': DateTime.now().toIso8601String(),
                'aud': 'authenticated',
                'role': 'authenticated',
                'email_confirmed_at': DateTime.now().toIso8601String(),
                'phone': '',
                'confirmed_at': DateTime.now().toIso8601String(),
                'last_sign_in_at': DateTime.now().toIso8601String(),
                'app_metadata': {'provider': 'email', 'providers': ['email']},
                'user_metadata': {},
                'identities': [],
                'updated_at': DateTime.now().toIso8601String(),
              }))!,  // Add the '!' operator here
            ),
            user: supabase.User.fromJson({
              'id': 'test_id',
              'email': 'test@example.com',
              'created_at': DateTime.now().toIso8601String(),
              'aud': 'authenticated',
              'role': 'authenticated',
              'email_confirmed_at': DateTime.now().toIso8601String(),
              'phone': '',
              'confirmed_at': DateTime.now().toIso8601String(),
              'last_sign_in_at': DateTime.now().toIso8601String(),
              'app_metadata': {'provider': 'email', 'providers': ['email']},
              'user_metadata': {},
              'identities': [],
              'updated_at': DateTime.now().toIso8601String(),
            }),
          ));

          await tester.pumpWidget(createWidgetUnderTest());

          // Fill in all fields correctly
          await tester.enterText(
              find.byType(TextFormField).at(0), 'Test User');
          await tester.enterText(
              find.byType(TextFormField).at(1), 'test@example.com');
          await tester.enterText(
              find.byType(TextFormField).at(2), 'password123');
          await tester.enterText(
              find.byType(TextFormField).at(3), 'password123');

          // Tap register button
          await tester.tap(find.text('Register'));
          await tester.pump();

          // Verify repository method was called with correct parameters
          verify(
            () => mockAuthRepository.signUpWithEmail(
              'Test User',
              'test@example.com',
              'password123',
            ),
          ).called(1);
        });

    testWidgets('should navigate to login screen when "Sign In" is tapped',
            (WidgetTester tester) async {
          await tester.pumpWidget(createWidgetUnderTest());

          // Tap on the Sign In text
          await tester.tap(find.text('Sign In'));
          await tester.pump();

          // Verify navigation
          verify(() => mockGoRouter.go('/login')).called(1);
    });

    testWidgets('should show loading indicator when registering',
        (WidgetTester tester) async {
      final completer = Completer<supabase.AuthResponse>();

      // Mock navigation to prevent infinite animations
      when(() => mockGoRouter.go(any())).thenReturn(null);

      when(() => mockAuthRepository.signUpWithEmail(any(), any(), any()))
          .thenAnswer((_) => completer.future);

      await tester.pumpWidget(createWidgetUnderTest());

      // Fill form and submit
      await tester.enterText(
          find.byType(TextFormField).at(0), 'Test User');
      await tester.pump();

      await tester.enterText(
          find.byType(TextFormField).at(1), 'test@example.com');
      await tester.pump();

      await tester.enterText(
          find.byType(TextFormField).at(2), 'password123');
      await tester.pump();

      await tester.enterText(
          find.byType(TextFormField).at(3), 'password123');
      await tester.pump();

      // Tap register button
      await tester.tap(find.text('Register'));
      await tester.pump();

      // Verify loading indicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Create user data
      final Map<String, dynamic> userData = {
        'id': 'test_id',
        'email': 'test@example.com',
        'created_at': DateTime.now().toIso8601String(),
        'aud': 'authenticated',
        'role': 'authenticated',
        'email_confirmed_at': DateTime.now().toIso8601String(),
        'phone': '',
        'confirmed_at': DateTime.now().toIso8601String(),
        'last_sign_in_at': DateTime.now().toIso8601String(),
        'app_metadata': <String, dynamic>{'provider': 'email', 'providers': ['email']},
        'user_metadata': <String, dynamic>{},
        'identities': <dynamic>[],
        'updated_at': DateTime.now().toIso8601String(),
      };

      final response = supabase.AuthResponse(
        session: supabase.Session(
          accessToken: 'fake_token',
          tokenType: '',
          expiresIn: 0,
          refreshToken: '',
          user: (supabase.User.fromJson(userData))!,
        ),
        user: supabase.User.fromJson(userData),
      );

      // Complete the future
      completer.complete(response);

      // Pump multiple times to ensure all animations and state changes are processed
      await tester.pump(); // Process the future completion
      await tester.pump(); // Process state update
      await tester.pump(const Duration(milliseconds: 100)); // Process animations
      await tester.pump(const Duration(milliseconds: 100)); // Additional frame for safety

      // Mock the home route for navigation
      when(() => mockGoRouter.go('/home')).thenReturn(null);

      // Pump again after navigation
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Verify loading indicator is gone
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Verify navigation occurred
      verify(() => mockGoRouter.go(any())).called(1);
    });
  });

}