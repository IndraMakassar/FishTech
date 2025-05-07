part of 'pond_bloc.dart';

sealed class PondEvent extends Equatable {
  const PondEvent();
}

class FetchPond extends PondEvent {
  @override
  List<Object?> get props => [];
}

class AddPond extends PondEvent {
  final String name;
  final String? fish;
  final double volume;

  const AddPond(this.name, this.fish, this.volume);

  @override
  List<Object?> get props => [name, fish, volume];
}
