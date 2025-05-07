import 'package:fishtech/model/pond_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PondRepository {
  final SupabaseClient _supabase;

  PondRepository({required SupabaseClient supabase}) : _supabase = supabase;

  Future<List<PondModel>> getAllPonds() async {
    final response = await _supabase.from('ponds').select().order('created_at');

    return (response as List<dynamic>)
        .map((data) => PondModel.fromJson(data as Map<String, dynamic>))
        .toList();
  }

  Future<PondModel?> getPondById(String id) async {
    final response = await _supabase.from('ponds').select().eq('id', id).maybeSingle();

    if (response == null) return null;

    return PondModel.fromJson(response);
  }

  Future<void> addPond(PondModel pond) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _supabase.from('ponds').insert(pond.toJson());
  }

  Future<void> deletePond(String id) async {
    await _supabase.from('ponds').delete().eq('id', id);
  }

  Future<void> updatePond(PondModel pond) async {
    await _supabase.from('ponds').update(pond.toJson()).eq('id', pond.id);
  }
}
