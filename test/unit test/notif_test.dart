import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fishtech/bloc/notification/notif_bloc.dart';
import 'package:fishtech/model/notification_model.dart';
import 'package:fishtech/repository/notif_repository.dart';

class MockNotifRepository extends Mock implements NotifRepository {}

void main() {
  late NotifBloc notifBloc;
  late MockNotifRepository mockRepo;

  setUp(() {
    mockRepo = MockNotifRepository();
    notifBloc = NotifBloc(mockRepo);
  });

  tearDown(() {
    notifBloc.close();
  });

  final sampleNotifs = [
    NotifModel(
      id: '1',
      title: 'Test Notif',
      body: 'Isi notifikasi',
      created_at: DateTime.now(),
      status: 'unread',
    ),
  ];

  group('NotifBloc Tests', () {
    test('Initial state harus NotifInitial', () {
      expect(notifBloc.state, equals(NotifInitial()));
    });

    group('FetchNotif event', () {
      test('Emit [NotifLoading, NotifSuccess] jika fetch berhasil', () {
        when(() => mockRepo.getNotifbyUser()).thenAnswer((_) async => sampleNotifs);

        final expectedStates = [
          NotifLoading(),
          NotifSuccess(notif: sampleNotifs),
        ];

        expectLater(notifBloc.stream, emitsInOrder(expectedStates));

        notifBloc.add(const FetchNotif());
      });

      test('Emit [NotifLoading, NotifFailure] jika fetch gagal', () {
        when(() => mockRepo.getNotifbyUser()).thenThrow(Exception('Failed to fetch'));

        final expectedStates = [
          NotifLoading(),
          isA<NotifFailure>(),
        ];

        expectLater(notifBloc.stream, emitsInOrder(expectedStates));

        notifBloc.add(const FetchNotif());
      });
    });

    group('UpdateNotifStatus event', () {
      test('Emit [NotifLoading, NotifSuccess] jika update berhasil', () async {
        when(() => mockRepo.updateNotificationStatus('1', 'read')).thenAnswer((_) async => {});
        when(() => mockRepo.getNotifbyUser()).thenAnswer((_) async => sampleNotifs);

        final expectedStates = [
          NotifLoading(),
          NotifSuccess(notif: sampleNotifs),
        ];

        expectLater(notifBloc.stream, emitsInOrder(expectedStates));

        notifBloc.add(const UpdateNotifStatus(notifId: '1', status: 'read'));
      });

      test('Emit [NotifLoading, NotifFailure] jika update gagal', () async {
        when(() => mockRepo.updateNotificationStatus('1', 'read')).thenThrow(Exception('Update failed'));

        final expectedStates = [
          NotifLoading(),
          isA<NotifFailure>(),
        ];

        expectLater(notifBloc.stream, emitsInOrder(expectedStates));

        notifBloc.add(const UpdateNotifStatus(notifId: '1', status: 'read'));
      });
    });
  });
}
