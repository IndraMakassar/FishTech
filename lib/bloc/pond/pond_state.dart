part of 'pond_bloc.dart';

sealed class PondState extends Equatable {
  const PondState();
}

final class PondInitial extends PondState {
  @override
  List<Object> get props => [];
}

final class PondSuccess extends PondState {
  final List<PondModel> ponds;

  const PondSuccess({required this.ponds});

  @override
  List<Object> get props => [ponds];
}

final class PondLoading extends PondState {
  @override
  List<Object> get props => [];
}

final class PondFailure extends PondState {
  final String message;

  const PondFailure({required this.message});

  @override
  List<Object> get props => [message];
}
