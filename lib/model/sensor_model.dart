  import 'package:equatable/equatable.dart';

  class SensorModel extends Equatable {
    final String id;
    final DateTime createdAt;
    final String name;
    final Status status;

    const SensorModel({
      required this.id,
      required this.createdAt,
      required this.name,
      required this.status,
    });

    factory SensorModel.fromJson(Map<String, dynamic> json) {
      return SensorModel(
        id: json['id'],
        createdAt: DateTime.parse(json['created_at']),
        name: json['name'],
        status: Status.values.firstWhere(
              (e) => e.toString() == 'Status.${json['status']}',
          orElse: () => Status.error, // Default value if status is invalid
        ),
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'name': name,
        'status': status.toString().split('.').last,
      };
    }


    @override
    List<Object?> get props => [id, createdAt, name, status];
  }

  enum Status { running, stopped, error }
