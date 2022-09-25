import 'dart:async';

import 'package:listenable_preferences/data_saver/repository/date_saver_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _datePrefKey = 'SECRET_DATE';

class PrefsDateSaverRepository implements DateSaverRepository {
  PrefsDateSaverRepository(SharedPreferences preferences)
      : _preferences = preferences;

  final SharedPreferences _preferences;

  @override
  Iterable<DateTime> getAllSavedDates() {
    final dates = <DateTime>[];
    final data = _preferences.getStringList(_datePrefKey) ?? [];

    try {
      dates.addAll(data.map(DateTime.parse));
    } catch (e) {
      rethrow;
    }

    return dates;
  }

  @override
  FutureOr<void> saveDate(DateTime date) async {
    final dates = [...getAllSavedDates(), date];

    await _preferences.setStringList(
      _datePrefKey,
      dates.map((d) => d.toIso8601String()).toList(),
    );
  }
}
