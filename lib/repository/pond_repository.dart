import 'package:fishtech/model/pond_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PondRepository {
  final SupabaseClient _supabase;

  PondRepository({required SupabaseClient supabase}) : _supabase = supabase;

  Future<List<PondModel>> getAllPonds() async {
    final pondList = await _supabase
    .from("ponds")
    .select();

    return (pondList).map((data) => PondModel.fromJson(data)).toList();
  }

  Future<PondModel> getPondById(String id) async {
    final pond = await _supabase.from("ponds").select().eq("id", id);

    return (pond).map((data) => PondModel.fromJson(data)).first;
  }

  addPond(PondModel pond) async {
    pond = await _supabase.from("ponds").insert(pond.toJson());
  }

}
