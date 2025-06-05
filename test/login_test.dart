import 'package:bloc_test/bloc_test.dart';
import 'package:fishtech/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fishtech/bloc/auth/auth_bloc.dart';
import 'package:fishtech/view/pages/pages.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late AuthBloc authBloc;

  setUp(() {
    authBloc = MockAuthBloc();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<AuthBloc>.value(
        value: authBloc,
        child: child,
      ),
    );
  }

  testWidgets('Menampilkan semua elemen utama pada LoginScreen',
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(AuthInitial());

    await tester.pumpWidget(makeTestableWidget(const LoginScreen()));

    expect(find.byType(FormFieldWidget), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });

  testWidgets('error jika email kosong atau tidak valid',
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(AuthInitial());

    await tester.pumpWidget(makeTestableWidget(const LoginScreen()));

    await tester.tap(find.text('Login'));
    await tester.pump(); // proses validasi form

    expect(find.text('Please enter your email'), findsOneWidget);
  });

  testWidgets('error jika password terlalu pendek',
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(AuthInitial());

    await tester.pumpWidget(makeTestableWidget(const LoginScreen()));

    await tester.enterText(find.byType(FormFieldWidget).last, '123');
    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Please enter your email'), findsOneWidget); 
    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
  });

  testWidgets('Mengirim event UserSignIn saat form valid',
      (WidgetTester tester) async {
    when(() => authBloc.state).thenReturn(AuthInitial());

    await tester.pumpWidget(makeTestableWidget(const LoginScreen()));

    await tester.enterText(find.byType(FormFieldWidget).first, 'user@mail.com');
    await tester.enterText(find.byType(FormFieldWidget).last, 'password123');
    await tester.tap(find.text('Login'));
    await tester.pump();

    verify(() => authBloc.add(
      const UserSignIn(email: 'user@mail.com', password: 'password123'),
    )).called(1);
  });

  testWidgets('Menampilkan SnackBar jika login gagal',
      (WidgetTester tester) async {
    whenListen(
      authBloc,
      Stream<AuthState>.fromIterable([
        AuthInitial(),
        const AuthFailure('Login gagal'),
      ]),
      initialState: AuthInitial(),
    );

    await tester.pumpWidget(makeTestableWidget(const LoginScreen()));
    await tester.pump(); 

    expect(find.text('Login gagal'), findsOneWidget);
  });
  
}
