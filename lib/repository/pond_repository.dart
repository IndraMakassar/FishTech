import 'package:fishtech/model/pond_card_model.dart';
import 'package:fishtech/model/pond_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PondRepository {
  final SupabaseClient _supabase;

  PondRepository({required SupabaseClient supabase}) : _supabase = supabase;

  Future<PondModel> addNewPond(PondModel pondModel) async {
    final data = await _supabase.from("ponds").insert(pondModel.toJson()).select();

    final newPondModel = PondModel.fromJson(data.first);

    return newPondModel;
  }

  Future<List<PondModel>> getAllPonds() async {
    final pondList = await _supabase
        .from("ponds")
        .select()
        .order('created_at', ascending: false);

    return (pondList).map((data) => PondModel.fromJson(data)).toList();
  }

  Future<PondModel> getPondById(String id) async {
    final pond = await _supabase.from("ponds").select().eq("id", id);

    return (pond).map((data) => PondModel.fromJson(data)).first;
  }

  addPond(PondModel pond) async {
    pond = await _supabase.from("ponds").insert(pond.toJson());
  }

  Future<List<PondCardModel>> getPondCards() async {
    // 2) Grab the base pond data via your existing method
    final ponds = await getAllPonds();

    final todayPrefix = DateTime.now().toIso8601String().substring(0, 10);
    final cards = <PondCardModel>[];

    // 3) For each PondModel, fetch sensors, feeders, logs, then build a PondCardModel
    for (final pond in ponds) {
      // — find the PH & Temp sensor IDs
      final sensorData =
          await _supabase.from('sensor').select().eq('pond_id', pond.id);

      String? phId, tempId;
      for (final s in sensorData) {
        if (s['type'] == 'ph') phId = s['id'];
        if (s['type'] == 'temp') tempId = s['id'];
      }

      // — helper to fetch the latest reading for a single sensor
      Future<double?> latest(String? sensorId) async {
        if (sensorId == null) return null;
        final r = await _supabase
            .from('data_sensor')
            .select('reading, created_at')
            .eq('sensor_id', sensorId)
            .order('created_at', ascending: false)
            .limit(1);
        if ((r as List).isEmpty) return null;
        return (r.first['reading'] as num).toDouble();
      }

      final ph = await latest(phId);
      final temperature = await latest(tempId);

      // — count autofeeders
      final feeders = await _supabase
          .from('autofeeder')
          .select('autofeeder_id')
          .eq('kolam_id', pond.id);
      final machineCount = (feeders as List).length;
      final feederIds =
          feeders.map((f) => f['autofeeder_id'] as String).toList();

      // — sum feed given today
      double totalFeed = 0;
      if (feederIds.isNotEmpty) {
        final logs = await _supabase
            .from('feedinglogs')
            .select('food_amount, created_at')
            .inFilter('autofeeder_id', feederIds);
        for (final log in (logs as List)) {
          if ((log['created_at'] as String).startsWith(todayPrefix)) {
            totalFeed += (log['food_amount'] as num).toDouble();
          }
        }
      }

      // — compute a simple “condition”
      String condition;
      if (ph == null || temperature == null) {
        condition = 'Unknown';
      } else if (ph < 6.5 || temperature > 30) {
        condition = 'Warning';
      } else {
        condition = 'Good';
      }

      // 4) build and collect the card model
      cards.add(PondCardModel(
        id: pond.id,
        name: pond.name,
        fish: pond.fish,
        fishAmount: pond.fishAmount,
        createdAt: pond.createdAt,
        volume: pond.volume,
        condition: condition,
        machineCount: machineCount,
        feedAmount: totalFeed,
        pH: ph ?? 0,
        temperature: temperature ?? 0,
      ));
    }

    return cards;
  }

  Future<List<Map<String, dynamic>>> fetchFilteredData({
    required String infoType,
    required String pondId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    if (infoType == 'Feed') {
      final feeders = await _supabase
          .from('autofeeder')
          .select('autofeeder_id')
          .eq('kolam_id', pondId);

      final feederIds = (feeders as List).map((e) => e['autofeeder_id']).toList();

      final logs = await _supabase
          .from('feedinglogs')
          .select('food_amount, created_at')
          .inFilter('autofeeder_id', feederIds)
          .gte('created_at', startDate.toIso8601String())
          .lt('created_at', endDate.toIso8601String());

      return logs;
    } else if (infoType == 'pH' || infoType == 'temp') {
      final sensorType = infoType == 'pH' ? 'ph' : 'temp';

      final sensors = await _supabase
          .from('sensor')
          .select('id')
          .eq('pond_id', pondId)
          .eq('type', sensorType);

      if (sensors.isEmpty) return [];

      final sensorId = sensors.first['id'];

      final readings = await _supabase
          .from('data_sensor')
          .select('reading, created_at')
          .eq('sensor_id', sensorId)
          .gte('created_at', startDate.toIso8601String())
          .lt('created_at', endDate.toIso8601String());

      return readings;
    }

    return [];
  }
}
