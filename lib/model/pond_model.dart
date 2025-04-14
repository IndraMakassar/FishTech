import 'package:equatable/equatable.dart';

class PondModel extends Equatable {
  final String id;
  final String name;
  final String fish;
  final DateTime createdAt;
  final double length;
  final double width;
  final double height;
  final double volume;



  const PondModel({
    required this.id,
    required this.name,
    required this.fish,
    required this.createdAt,
    required this.length,
    required this.width,
    required this.height,
    required this.volume,

  });

  @override
  List<Object?> get props => [id, createdAt, name, fish, length, width, height, volume];

  factory PondModel.fromJson(Map<String, dynamic> data) {
    return PondModel(
      id: data["id"],
      name: data["name"],
      fish: data["fish"],
      createdAt: DateTime.parse(data["created_at"]),
      length: data["length"],
      width: data["width"],
      height: data["height"],
      volume: data["volume"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "fish":fish,
      "length":length,
      "width":width,
      "height":height,
      "volume":volume,
    };
  }
  PondModel copyWith({
    String? id,
    String? name,
    String? fish,
    DateTime? createdAt,
    double? length,
    double? width,
    double? height,
    double? volume
  }){
    return PondModel(
      id: id??this.id,
      name: name??this.name,
      fish: fish??this.fish,
      createdAt: createdAt?? this.createdAt,
      length: length?? this.length,
      width: width?? this.width,
      height: height??this.height,
      volume: volume??this.volume
    );
  }
}
