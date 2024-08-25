import 'package:calendar_gymatech/widgets/schedule_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widgets/api/api_service.dart';
import 'package:widgets/custom_tag.dart';
import 'package:widgets/models/list_item.dart';
import 'package:widgets/logger/app_logger.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  int currentWeekNumber = 1;
  DateTime _selectedDay = DateTime.now();

  List<ScheduleElement> scheduleElements = [];

  ScheduleCubit() : super(ScheduleInitial());

  DateTime get selectedDay => _selectedDay;

  Future<void> loadSchedule() async {
    AppLogger.i("Loading schedule...");
    try {
      emit(ScheduleLoading());
      List<ListItem> data = await ApiService.fetchListItems(currentWeekNumber);
      AppLogger.i("Data loaded: $data"); // Debug message

      List<ScheduleElement> scheduleElements = data.map((item) {
        return ScheduleElement(
          item: item,
          date: item.dateDateTime,
          timeTag: CustomTag(
            disabledBackgroundColor: const Color(0xFFD6B5FF),
            text: Text(
              "${item.timeStart} - ${item.endTime}",
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12),
            ),
            leftIcon: SvgPicture.asset("assets/svgs/clock.svg"),
            showleftIcon: true,
          ),
          variant: ScheduleVariant.standart,
        );
      }).toList();

      this.scheduleElements = scheduleElements;
      emit(ScheduleLoaded(data: scheduleElements));
    } catch (e) {
      AppLogger.e('Error loading schedule: $e');
      emit(ScheduleError());
    }
  }

  void updateWeek(int weeks) {
    currentWeekNumber += weeks;
    loadSchedule();
  }

  void updateSelectedDay(DateTime newDay) {
    _selectedDay = newDay;
    emit(ScheduleSelectedDay(selectedDay: newDay));
    emit(ScheduleLoaded(data: scheduleElements));
  }
}
