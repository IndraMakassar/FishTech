import 'package:equatable/equatable.dart';

class PondModel extends Equatable {
  final String id;
  final DateTime createdAt;
  final String name;
  final double? volume;
  final String? fish;
  final int? fishAmount;

  const PondModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.volume,
    required this.fish,
    required this.fishAmount,
  });

  @override
  List<Object?> get props => [id, createdAt, name, fish, volume, fishAmount];

  factory PondModel.fromJson(Map<String, dynamic> data) {
    return PondModel(
      id: data["id"],
      createdAt: DateTime.parse(data["created_at"]),
      name: data["name"] as String,
      volume: data["volume"] == null ? null : (data["volume"] as num).toDouble(),
      fish: data["fish"] as String?,
      fishAmount: data["fish_amount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "volume": volume,
      "fish": fish,
      "fish_amount": fishAmount,
    };
  }

  PondModel copyWith({
    String? id,
    String? name,
    String? fish,
    DateTime? createdAt,
    double? volume,
    int? fishAmount
  }) {
    return PondModel(
      id: id ?? this.id,
      name: name ?? this.name,
      fish: fish ?? this.fish,
      createdAt: createdAt ?? this.createdAt,
      volume: volume ?? this.volume,
      fishAmount: fishAmount ?? this.fishAmount,
    );
  }
}
