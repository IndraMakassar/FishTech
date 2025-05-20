import 'package:equatable/equatable.dart';

class PondCardModel extends Equatable {
  final String id;
  final String name;
  final String? fish;
  final DateTime createdAt;
  final double? volume;
  final String condition;
  final int machineCount;
  final double feedAmount;
  final double pH;
  final double temperature;
  final DateTime? lastAutofeederOn;

  const PondCardModel({
    required this.id,
    required this.name,
    required this.fish,
    required this.createdAt,
    required this.volume,
    this.condition = 'Unknown',
    this.machineCount = 0,
    this.feedAmount = 0.0,
    this.pH = 0.0,
    this.temperature = 0.0,
    this.lastAutofeederOn,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    fish,
    createdAt,
    volume,
    condition,
    machineCount,
    feedAmount,
    pH,
    temperature,
    lastAutofeederOn,
  ];

  factory PondCardModel.fromJson(Map<String, dynamic> data) {
    return PondCardModel(
      id: data["id"],
      name: data["name"] as String,
      fish: data["fish"] as String?,
      createdAt: DateTime.parse(data["created_at"]),
      volume: (data["volume"] as num).toDouble(),
      condition: data["condition"] ?? 'Unknown',
      machineCount: data["machine_count"] ?? 0,
      feedAmount: (data["feed_amount"] ?? 0).toDouble(),
      pH: (data["ph"] ?? 0).toDouble(),
      temperature: (data["temperature"] ?? 0).toDouble(),
      lastAutofeederOn: data['last_autofeeder_on'] != null
          ? DateTime.parse(data['last_autofeeder_on'])
          : null,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "fish": fish,
      "created_at": createdAt.toIso8601String(),
      "volume": volume,
      "condition": condition,
      "machine_count": machineCount,
      "feed_amount": feedAmount,
      "ph": pH,
      "temperature": temperature,
      "last_autofeeder_on": lastAutofeederOn?.toIso8601String(),
    };
  }

  PondCardModel copyWith({
    String? id,
    String? name,
    String? fish,
    DateTime? createdAt,
    double? volume,
    String? condition,
    int? machineCount,
    double? feedAmount,
    double? pH,
    double? temperature,
    DateTime? lastAutofeederOn,
  }) {
    return PondCardModel(
      id: id ?? this.id,
      name: name ?? this.name,
      fish: fish ?? this.fish,
      createdAt: createdAt ?? this.createdAt,
      volume: volume ?? this.volume,
      condition: condition ?? this.condition,
      machineCount: machineCount ?? this.machineCount,
      feedAmount: feedAmount ?? this.feedAmount,
      pH: pH ?? this.pH,
      temperature: temperature ?? this.temperature,
      lastAutofeederOn: lastAutofeederOn ?? this.lastAutofeederOn
    );
  }
}
