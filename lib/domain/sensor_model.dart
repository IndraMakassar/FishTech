import 'package:equatable/equatable.dart';

class SensorModel extends Equatable {
  final String id;
  final String name;
  final Status status;

  const SensorModel({
    required this.id,
    required this.name,
    required this.status,
  });

  @override
  List<Object?> get props => [id, name, status];
}

enum Status { running, stopped, error }
