part of 'pond_bloc.dart';

sealed class PondEvent extends Equatable {
  const PondEvent();
}

class FetchPond extends PondEvent {
  const FetchPond();

  @override
  List<Object?> get props => [];
}

class AddNewPond extends PondEvent {
  final PondModel pondModel;

  const AddNewPond({required this.pondModel});

  @override
  List<Object?> get props => [pondModel];
}
