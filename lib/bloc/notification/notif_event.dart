part of 'notif_bloc.dart';

sealed class NotifEvent extends Equatable{
  const NotifEvent();
}

class FetchNotif extends NotifEvent {
  const FetchNotif();

  @override
  List<Object?> get props => [];
}

class UpdateNotifStatus extends NotifEvent {
  final String notifId;
  final String status;

  const UpdateNotifStatus({
    required this.notifId,
    required this.status,
  });

  @override
  List<Object?> get props => [notifId, status];
}