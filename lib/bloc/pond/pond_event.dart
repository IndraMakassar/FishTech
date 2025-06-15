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

class FetchFilteredData extends PondEvent {
  final String infoType;
  final String pondId;
  final DateTime startDate;

  const FetchFilteredData({
    required this.infoType,
    required this.pondId,
    required this.startDate,
  });

  @override
  List<Object?> get props => [infoType, pondId, startDate];
}