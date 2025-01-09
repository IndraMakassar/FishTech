import 'package:equatable/equatable.dart';

class SensorDataModel extends Equatable {
  final String id;
  final double ph;
  final double temperature;
  final DateTime timestamp;

  const SensorDataModel({
    required this.id,
    required this.ph,
    required this.temperature,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, ph, temperature, timestamp];
}
