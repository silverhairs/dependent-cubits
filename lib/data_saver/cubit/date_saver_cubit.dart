import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listenable_preferences/data_saver/repository/date_saver_repository.dart';

part 'date_saver_state.dart';

class DateSaverCubit extends Cubit<DateSaverState> {
  DateSaverCubit(DateSaverRepository repository)
      : _repository = repository,
        super(DateSaverInitial());

  final DateSaverRepository _repository;

  Future<void> loadDates() async {
    emit(DateSaverLoading());
    try {
      final dates = await _repository.getAllSavedDates();
      emit(DatesLoaded(dates.toList()));
    } catch (e, s) {
      emit(DateSaverFailure('$e'));

      addError(e, s);
    }
  }

  Future<void> saveNewDate(DateTime date) async {
    emit(DateSaverLoading());
    try {
      await _repository.saveDate(date);
      final dates = await _repository.getAllSavedDates();
      emit(DatesLoaded(dates.toList()));
    } catch (e, s) {
      emit(DateSaverFailure('$e'));
      addError(e, s);
    }
  }
}
