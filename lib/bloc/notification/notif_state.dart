part of 'notif_bloc.dart';

sealed class NotifState extends Equatable {
  const NotifState();
}

final class NotifInitial extends NotifState{
  @override
  List<Object> get props => [];
}

final class NotifSuccess extends NotifState{
  final List<NotifModel> notif;
  const NotifSuccess({required this.notif});
  @override
  List<Object> get props => [notif];
}

final class NotifLoading extends NotifState{
  @override
  List<Object> get props => [];
}

final class NotifFailure extends NotifState{
  final String message;

  const NotifFailure({required this.message});
  @override
  List<Object> get props => [message];
}