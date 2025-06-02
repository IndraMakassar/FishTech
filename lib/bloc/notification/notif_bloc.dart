import 'package:equatable/equatable.dart';
import 'package:fishtech/model/notification_model.dart';
import 'package:fishtech/repository/notif_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notif_event.dart';
part 'notif_state.dart';

class NotifBloc extends Bloc<NotifEvent, NotifState> {
  final NotifRepository _repository;
  NotifBloc(this._repository) : super(NotifInitial()) {
    on<FetchNotif>((event, emit) async {
      emit(NotifLoading());
      try {
        final notif = await _repository.getNotifbyUser();
        emit(NotifSuccess(notif: notif));
      } catch (e) {
        emit(NotifFailure(message: e.toString()));
      }
    });

    on<UpdateNotifStatus>((event, emit) async {
      emit(NotifLoading());
      try {
        await _repository.updateNotificationStatus(event.notifId, event.status);
        // Refresh the notifications after update
        final notif = await _repository.getNotifbyUser();
        emit(NotifSuccess(notif: notif));
      } catch (e) {
        emit(NotifFailure(message: e.toString()));
      }
    });
  }
}