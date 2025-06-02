import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fishtech/model/notification_model.dart';

class NotifRepository {
  final SupabaseClient _supabase;
  NotifRepository({required SupabaseClient supabase}) : _supabase = supabase;

  Future<List<NotifModel>> getNotifbyUser() async {
    // Get current user's UID
    final currentUser = _supabase.auth.currentUser;
    if (currentUser == null) {
      throw Exception('No authenticated user found');
    }

    final notifList = await _supabase
        .from("notifications")  // Fixed the typo in table name
        .select()
        .eq('user_id', currentUser.id)  // Filter by current user's ID
        .order('created_at', ascending: false);

    return (notifList).map((data) => NotifModel.fromJson(data)).toList();
  }

  Future<void> updateNotificationStatus(String notifId, String status) async {
    await _supabase
        .from("notifications")
        .update({'status': status})
        .eq('id', notifId);
  }
}