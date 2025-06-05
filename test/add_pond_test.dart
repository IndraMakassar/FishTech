import 'package:fishtech/bloc/pond/pond_bloc.dart';
import 'package:fishtech/view/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockPondBloc extends Mock implements PondBloc {}

void main() {
  late PondBloc pondBloc;

  setUp(() {
    pondBloc = MockPondBloc();
    when(() => pondBloc.state).thenReturn(PondInitial());
  });

  Future<void> _buildWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<PondBloc>.value(
          value: pondBloc,
          child: const AddPond(),
        ),
      ),
    );
  }

  group('AddPond Widget Test', () {
    testWidgets('Menampilkan semua field input', (tester) async {
      await _buildWidget(tester);

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Fish Type'), findsOneWidget);
      expect(find.text('Fish Amount'), findsOneWidget);
      expect(find.text('Start Date'), findsOneWidget);
      expect(find.text('Volume Pond (m³)'), findsOneWidget);
      expect(find.text('Add Pond'), findsOneWidget);
    });

    testWidgets('Menampilkan error saat form kosong dan tombol ditekan', (tester) async {
      await _buildWidget(tester);

      await tester.tap(find.text('Add Pond'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your pond name'), findsOneWidget);
      expect(find.text('Please enter your fish type'), findsOneWidget);
      expect(find.text('Please enter your fish amount'), findsOneWidget);
      expect(find.text('Please enter the date'), findsOneWidget);
      expect(find.text('Please enter the pond volume'), findsOneWidget);
    });

    testWidgets('Memanggil AddNewPond saat form valid', (tester) async {
      when(() => pondBloc.add(any())).thenReturn(null);

      await _buildWidget(tester);

      await tester.enterText(find.byType(TextFormField).at(0), 'Kolam A');
      await tester.enterText(find.byType(TextFormField).at(1), 'Nila');
      await tester.enterText(find.byType(TextFormField).at(2), '50');
      await tester.enterText(find.byType(TextFormField).at(3), '01-06-2024');
      await tester.enterText(find.byType(TextFormField).at(4), '15.5');

      await tester.tap(find.text('Add Pond'));
      await tester.pump();

      verify(() => pondBloc.add(any(that: isA<AddNewPond>()))).called(1);
    });
  });
}
