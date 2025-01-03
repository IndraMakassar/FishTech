import 'package:equatable/equatable.dart';

class SensorEntity extends Equatable {
  final String id;
  final String name;
  final Status status;

  const SensorEntity({
    required this.id,
    required this.name,
    required this.status,
  });

  @override
  List<Object?> get props => [id, name, status];
}

enum Status { running, stopped, error }
