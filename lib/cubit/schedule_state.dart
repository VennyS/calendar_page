part of 'schedule_cubit.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<ScheduleElement> data;

  const ScheduleLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class ScheduleSelectedDay extends ScheduleState {
  final DateTime selectedDay;

  const ScheduleSelectedDay({required this.selectedDay});

  @override
  List<Object?> get props => [selectedDay];
}

class ScheduleError extends ScheduleState {}
