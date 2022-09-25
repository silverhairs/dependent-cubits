import 'dart:async';

abstract class DateSaverRepository {
  FutureOr<Iterable<DateTime>> getAllSavedDates();

  FutureOr<void> saveDate(DateTime date);
}
