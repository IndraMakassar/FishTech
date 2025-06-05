import 'package:flutter_test/flutter_test.dart';
import 'package:fishtech/model/pond_model.dart';

void main() {
  group('PondModel', () {
    final sampleJson = {
      "id": "1",
      "created_at": "2024-06-05T10:00:00Z",
      "name": "Kolam A",
      "volume": 10.5,
      "fish": "Lele",
      "fish_amount": 100
    };

    final sampleModel = PondModel(
      id: "1",
      createdAt: DateTime.parse("2024-06-05T10:00:00Z"),
      name: "Kolam A",
      volume: 10.5,
      fish: "Lele",
      fishAmount: 100,
    );

    test('fromJson harus menghasilkan instance PondModel yang benar', () {
      final result = PondModel.fromJson(sampleJson);
      expect(result, equals(sampleModel));
    });

    test('toJson harus menghasilkan Map yang sesuai', () {
      final result = sampleModel.toJson();
      expect(result, {
        "name": "Kolam A",
        "volume": 10.5,
        "fish": "Lele",
        "fish_amount": 100,
      });
    });

    test('copyWith harus mengubah field yang ditentukan dan mempertahankan yang lain', () {
      final updated = sampleModel.copyWith(name: "Kolam B", volume: 12.0);
      expect(updated.name, "Kolam B");
      expect(updated.volume, 12.0);
      expect(updated.fish, sampleModel.fish); 
      expect(updated.createdAt, sampleModel.createdAt);
    });

    test('Equatable harus membandingkan berdasarkan props', () {
      final model1 = sampleModel;
      final model2 = PondModel(
        id: "1",
        createdAt: DateTime.parse("2024-06-05T10:00:00Z"),
        name: "Kolam A",
        volume: 10.5,
        fish: "Lele",
        fishAmount: 100,
      );

      expect(model1 == model2, isTrue);
    });
  });
}
