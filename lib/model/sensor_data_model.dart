import 'package:equatable/equatable.dart';

class SensorDataModel extends Equatable {
  final String id;
  final double ph;
  final double temperature;
  final DateTime createdAt;

  const SensorDataModel({
    required this.id,
    required this.ph,
    required this.temperature,
    required this.createdAt,
  });

  factory SensorDataModel.fromJson(Map<String, dynamic> json) {
    return SensorDataModel(
      id: json['id'],
      ph: json['ph'].toDouble(),
      temperature: json['temperature'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ph': ph,
      'temperature': temperature,
    };
  }


  @override
  List<Object?> get props => [id, ph, temperature, createdAt];
}
