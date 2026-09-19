import 'package:shared_preferences/shared_preferences.dart';

import '../models/history_item_model.dart';

class HistoryService {
  static const String _historyKey = 'docs_admins_history';

  static final SharedPreferencesAsync _preferences =
      SharedPreferencesAsync();

  static Future<List<HistoryItemModel>> getHistory() async {
    final data = await _preferences.getStringList(
      _historyKey,
    );

    if (data == null || data.isEmpty) {
      return [];
    }

    final history = <HistoryItemModel>[];

    for (final item in data) {
      try {
        history.add(
          HistoryItemModel.fromJson(item),
        );
      } catch (_) {
        // Ignore les éléments invalides.
      }
    }

    history.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    return history;
  }

  static Future<void> addHistoryItem(
    HistoryItemModel item,
  ) async {
    final existing = await getHistory();

    existing.removeWhere(
      (element) => element.id == item.id,
    );

    existing.insert(0, item);

    final limitedHistory = existing
        .take(50)
        .toList();

    final encoded = limitedHistory
        .map(
          (element) => element.toJson(),
        )
        .toList();

    await _preferences.setStringList(
      _historyKey,
      encoded,
    );
  }

  static Future<void> deleteHistoryItem(
    String id,
  ) async {
    final history = await getHistory();

    history.removeWhere(
      (item) => item.id == id,
    );

    final encoded = history
        .map(
          (item) => item.toJson(),
        )
        .toList();

    await _preferences.setStringList(
      _historyKey,
      encoded,
    );
  }

  static Future<void> clearHistory() async {
    await _preferences.remove(
      _historyKey,
    );
  }
}