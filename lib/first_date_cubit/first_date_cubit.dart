import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listenable_preferences/data_saver/cubit/date_saver_cubit.dart';

part 'first_date_state.dart';

class FirstDateCubit extends Cubit<FirstDateState> {
  FirstDateCubit() : super(FirstDateInitial());

  Future<void> onMainCubitEmits(DateSaverState dateSaverState) async {
    if (dateSaverState is DatesLoaded) {
      emit(FirstDateLoaded(dateSaverState.dates));
    } else if (dateSaverState is DateSaverFailure) {
      emit(FirstDateFailure(dateSaverState.message));
    } else if (dateSaverState is DateSaverLoading) {
      emit(FirstDateLoading());
    }
  }
}
