part of 'pond_bloc.dart';

sealed class PondState extends Equatable {
  const PondState();
}

final class PondInitial extends PondState {
  @override
  List<Object> get props => [];
}

class PondAddSuccess extends PondState {
  @override
  List<Object?> get props => [];
}

final class PondSuccess extends PondState {
  final List<PondCardModel> ponds;

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

// In pond_state.dart
final class FilteredDataSuccess extends PondState {
  final List<Map<String, dynamic>> data;
  final List<PondCardModel> ponds;  // Add this

  const FilteredDataSuccess({
    required this.data,
    required this.ponds,  // Add this
  });

  @override
  List<Object> get props => [data, ponds];
}