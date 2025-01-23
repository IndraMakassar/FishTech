part of 'pond_bloc.dart';

sealed class PondEvent extends Equatable {
  const PondEvent();
}

class FetchPond extends PondEvent {
  @override
  List<Object?> get props => [];
}
