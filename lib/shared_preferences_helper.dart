
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _pondIdsKey = 'pond_ids'; // Key for storing pond IDs

  // Save a list of pond IDs
  static Future<void> savePondIds(List<String> pondIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_pondIdsKey, pondIds); // Save the list
  }

  // Retrieve the list of pond IDs
  static Future<List<String>> getPondIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_pondIdsKey) ?? []; // Return an empty list if no data exists
  }

  // Add a single pond ID to the list
  static Future<void> addPondId(String pondId) async {
    final List<String> pondIds = await getPondIds(); // Get existing pond IDs
    if (!pondIds.contains(pondId)) {
      pondIds.add(pondId); // Add the new pond ID if it doesn't already exist
      await savePondIds(pondIds); // Save the updated list
    }
  }

  // Remove a single pond ID from the list
  static Future<void> removePondId(String pondId) async {
    final List<String> pondIds = await getPondIds(); // Get existing pond IDs
    pondIds.remove(pondId); // Remove the pond ID
    await savePondIds(pondIds); // Save the updated list
  }
}