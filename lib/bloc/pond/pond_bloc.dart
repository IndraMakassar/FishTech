import 'package:equatable/equatable.dart';
import 'package:fishtech/model/pond_card_model.dart';
import 'package:fishtech/model/pond_model.dart';
import 'package:fishtech/repository/pond_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pond_event.dart';

part 'pond_state.dart';

class PondBloc extends Bloc<PondEvent, PondState> {
  final PondRepository _repository;
  List<PondCardModel> _ponds = [];  // Add this to store ponds


  PondBloc(this._repository) : super(PondInitial()) {
    on<FetchPond>((event, emit) async {
      emit(PondLoading());
      try {
        final ponds = await _repository.getPondCards();
        _ponds = ponds;  // Store ponds
        emit(PondSuccess(ponds: ponds));
      } catch (e) {
        emit(PondFailure(message: e.toString()));
      }
    });

    on<AddNewPond>((event, emit) async {
      emit(PondLoading());
      try {
        await _repository.addNewPond(event.pondModel);
        emit(PondAddSuccess());
        add(const FetchPond());
      } catch (e) {
        emit(PondFailure(message: e.toString()));
      }
    });
    on<FetchFilteredData>((event, emit) async {
      emit(PondLoading());
      try {
        final filteredData = await _repository.fetchFilteredData(
          infoType: event.infoType,
          pondId: event.pondId,
          startDate: event.startDate,
        );
        emit(FilteredDataSuccess(
          data: filteredData,
          ponds: _ponds,  // Include current ponds
        ));
      } catch (e) {
        emit(PondFailure(message: e.toString()));
      }
    });
  }
}