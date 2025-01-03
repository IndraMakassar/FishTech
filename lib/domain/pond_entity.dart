import 'package:equatable/equatable.dart';

class Pond extends Equatable {
  final String id;
  final String name;

  const Pond({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
