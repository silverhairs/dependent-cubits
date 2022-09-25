part of 'second_date_cubit.dart';

abstract class SecondDateState extends Equatable {
  const SecondDateState();

  @override
  List<Object?> get props => [];
}

class SecondDateInitial extends SecondDateState {}

class SecondDateLoading extends SecondDateState {}

class SecondDateLoaded extends SecondDateState {
  const SecondDateLoaded(this.dates);

  final List<DateTime> dates;

  @override
  List<Object> get props => [...dates];
}

class SecondDateFailure extends SecondDateState {
  const SecondDateFailure([this.message]);

  final String? message;

  @override
  List<Object?> get props => [message];
}
