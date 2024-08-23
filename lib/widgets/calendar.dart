import 'package:calendar_gymatech/cubit/schedule_cubit.dart';
import 'package:calendar_gymatech/widgets/week_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CalendarCard extends StatelessWidget {
  final int monthsScrolledForward = 0;

  const CalendarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        DateTime selectedDay = context.read<ScheduleCubit>().selectedDay;
        DateTime currentWeekStart = _getStartOfWeek(selectedDay);
        String currentMonth =
            DateFormat('MMMM', 'ru_RU').format(currentWeekStart);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFFF7EEFF),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _monthPart(context, currentMonth),
              WeekList(currentWeekStart: currentWeekStart),
            ],
          ),
        );
      },
    );
  }

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  Widget _monthPart(BuildContext context, String currentMonth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: SvgPicture.asset(
            "assets/svgs/arrow.svg",
            width: 18,
            colorFilter: ColorFilter.mode(
              _canMoveBack(context)
                  ? const Color(0xFFA03FFF)
                  : const Color(0xFFDAD0E3),
              BlendMode.srcIn,
            ),
          ),
          onPressed:
              _canMoveBack(context) ? () => _moveWeek(context, -1) : null,
        ),
        Text(
          currentMonth.toUpperCase(),
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        IconButton(
          icon: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationZ(3.14159),
            child: SvgPicture.asset(
              "assets/svgs/arrow.svg",
              width: 18,
              colorFilter:
                  const ColorFilter.mode(Color(0xFFA03FFF), BlendMode.srcIn),
            ),
          ),
          onPressed: () => _moveWeek(context, 1),
        ),
      ],
    );
  }

  bool _canMoveBack(BuildContext context) {
    DateTime currentWeekStart =
        _getStartOfWeek(context.read<ScheduleCubit>().selectedDay);
    DateTime minWeekStart = _getStartOfWeek(DateTime.now());
    return currentWeekStart.isAfter(minWeekStart);
  }

  void _moveWeek(BuildContext context, int weeks) {
    DateTime newSelectedDay = context
        .read<ScheduleCubit>()
        .selectedDay
        .add(Duration(days: weeks * 7));
    context.read<ScheduleCubit>().updateSelectedDay(newSelectedDay);
    context.read<ScheduleCubit>().updateWeek(weeks);
  }
}
