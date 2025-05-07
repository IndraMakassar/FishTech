import 'package:equatable/equatable.dart';
import 'package:fishtech/model/pond_model.dart';
import 'package:fishtech/repository/pond_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pond_event.dart';

part 'pond_state.dart';

class PondBloc extends Bloc<PondEvent, PondState> {
  final PondRepository _repository;

  PondBloc(this._repository) : super(PondInitial()) {
    on<PondEvent>((event, emit) {});

    on<AddPond>((event, emit) async {
      emit(PondLoading());
      try {
        final pond = PondModel(
            id: "",
            name: event.name,
            fish: event.fish,
            createdAt: DateTime.now(),
            volume: event.volume
        );

        await _repository.addPond(pond);

        add(FetchPond());
      } catch (e) {
        emit(PondFailure(message: e.toString()));
      }
    });

    on<FetchPond>((event, emit) async {
      emit(PondLoading());
      try {
        final ponds = await _repository.getAllPonds();
        emit(PondSuccess(ponds: ponds));
      } catch (e) {
        emit(PondFailure(message: e.toString()));
      }
    });
  }
}
