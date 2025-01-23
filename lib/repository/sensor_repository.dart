import 'dart:ffi';

import 'package:fishtech/model/pond_model.dart';
import 'package:fishtech/model/sensor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PondRepository {
  final SupabaseClient _supabase;

  PondRepository({required SupabaseClient supabase}) : _supabase = supabase;

  Future<List<SensorModel>> getSensorByPond(PondModel pond) async {
    final sensorList = await _supabase
        .from("sensor")
        .select().eq('pond', pond.id);

    return (sensorList).map((data) => SensorModel.fromJson(data)).toList();
  }
  
  addSensor(SensorModel sensor) async {
    await _supabase.from('sensor').insert(sensor.toJson());
  }
}
