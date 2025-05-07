import 'package:equatable/equatable.dart';

class PondModel extends Equatable {
  final String id;
  final String name;
  final String? fish;
  final DateTime createdAt;
  final double? volume;

  const PondModel({
    required this.id,
    required this.name,
    required this.fish,
    required this.createdAt,
    required this.volume,
  });

  @override
  List<Object?> get props => [id, createdAt, name, fish, volume];

  factory PondModel.fromJson(Map<String, dynamic> data) {
    return PondModel(
      id: data["id"],
      name: data["name"] ?? '',
      fish: data["fish"],
      createdAt: DateTime.parse(data["created_at"]),
      volume: (data["volume"] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "fish": fish,
      "volume": volume,
    };
  }

  PondModel copyWith(
      {String? id,
      String? name,
      String? fish,
      DateTime? createdAt,
      double? volume}) {
    return PondModel(
        id: id ?? this.id,
        name: name ?? this.name,
        fish: fish ?? this.fish,
        createdAt: createdAt ?? this.createdAt,
        volume: volume ?? this.volume);
  }
}
