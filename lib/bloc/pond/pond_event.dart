part of 'pond_bloc.dart';

sealed class PondEvent extends Equatable {
  const PondEvent();
}

class FetchPond extends PondEvent {
  const FetchPond();

  @override
  List<Object?> get props => [];
}
