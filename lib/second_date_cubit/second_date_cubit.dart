import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listenable_preferences/data_saver/cubit/date_saver_cubit.dart';

part 'second_date_state.dart';

class SecondDateCubit extends Cubit<SecondDateState> {
  SecondDateCubit() : super(SecondDateInitial());

  Future<void> onMainCubitEmits(DateSaverState dateSaverState) async {
    if (dateSaverState is DatesLoaded) {
      emit(SecondDateLoaded(dateSaverState.dates));
    } else if (dateSaverState is DateSaverFailure) {
      emit(SecondDateFailure(dateSaverState.message));
    } else if (dateSaverState is DateSaverLoading) {
      emit(SecondDateLoading());
    }
  }
}
