part of 'first_date_cubit.dart';

abstract class FirstDateState extends Equatable {
  const FirstDateState();

  @override
  List<Object?> get props => [];
}

class FirstDateInitial extends FirstDateState {}

class FirstDateLoading extends FirstDateState {}

class FirstDateLoaded extends FirstDateState {
  const FirstDateLoaded(this.dates);
  final List<DateTime> dates;

  @override
  List<Object> get props => [...dates];
}

class FirstDateFailure extends FirstDateState {
  const FirstDateFailure([this.message]);
  final String? message;

  @override
  List<Object?> get props => [message];
}
