part of 'date_saver_cubit.dart';

abstract class DateSaverState extends Equatable {
  const DateSaverState();

  @override
  List<Object?> get props => [];
}

class DateSaverInitial extends DateSaverState {}

class DatesLoaded extends DateSaverState {
  const DatesLoaded(this.dates);

  final List<DateTime> dates;
  @override
  List<Object> get props => [...dates];
}

class DateSaverLoading extends DateSaverState {}

class DateSaverFailure extends DateSaverState {
  const DateSaverFailure([this.message]);

  final String? message;

  @override
  List<Object?> get props => [message];
}
