import 'package:equatable/equatable.dart';

class PondModel extends Equatable {
  final String id;
  final DateTime createdAt;
  final String name;

  const PondModel({
    required this.id,
    required this.createdAt,
    required this.name,
  });

  @override
  List<Object?> get props => [id, createdAt, name];

  factory PondModel.fromJson(Map<String, dynamic> data) {
    return PondModel(
      id: data["id"],
      createdAt: DateTime.parse(data["created_at"]),
      name: data["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }

}
