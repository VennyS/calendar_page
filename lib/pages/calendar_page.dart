import 'package:calendar_gymatech/typedef.dart';
import 'package:calendar_gymatech/pages/filter_page.dart';
import 'package:widgets/calendar.dart';
import 'package:widgets/cubit/schedule_cubit.dart';
import 'package:widgets/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:widgets/custom_tag.dart';
import 'package:widgets/models/list_item.dart';
import 'package:widgets/models/spots.dart';
import 'package:widgets/schedule_element.dart';

class CalendarPage extends StatelessWidget {
  final GtoPageBuilder gtoPageBuilder;
  const CalendarPage({super.key, required this.gtoPageBuilder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            FilterButton(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FilterPage()),
              ),
            ),
            const SizedBox(width: 16),
          ],
          title: Text(
            "Расписание",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              height: 20 / 24,
              letterSpacing: 0.1,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const CalendarCard(),
                const SizedBox(height: 12),
                BlocBuilder<ScheduleCubit, ScheduleState>(
                  builder: (context, state) {
                    if (state is ScheduleLoading) {
                      return ScheduleElement(
                        date: DateTime.now(),
                        item: ListItem(
                            gtoId: 1,
                            dayOfWeek: "",
                            date: "",
                            timeStart: "",
                            name: "",
                            coachName: "",
                            trainerPhotoUrl: "",
                            duration: 0,
                            status: true,
                            spots: Spots(
                                maxSpots: 1,
                                currentSpots: 2,
                                confirmed: 3,
                                canceled: 4,
                                missed: 5,
                                notConfirmed: 6,
                                waitingList: 7)),
                        timeTag: const CustomTag(text: Text("")),
                        variant: ScheduleVariant.skeleton,
                      );
                    } else if (state is ScheduleLoaded) {
                      if (state.data
                          .where((element) => isSameDay(element.date,
                              context.read<ScheduleCubit>().selectedDay))
                          .isEmpty) {
                        return nothingWasFound(context);
                      } else {
                        return Column(
                          children: state.data
                              .where((element) => isSameDay(element.date,
                                  context.read<ScheduleCubit>().selectedDay))
                              .map((widget) {
                            return GestureDetector(
                                onTap: () => Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return gtoPageBuilder(widget.item);
                                    })),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: widget,
                                ));
                          }).toList(),
                        );
                      }
                    } else {
                      return nothingWasFound(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  // TODO: Центрировать
  Widget nothingWasFound(BuildContext context) {
    DateTime selectedDay = context.read<ScheduleCubit>().selectedDay;

    String currentMonth =
        DateFormat('d MMMM yyyy', 'ru_RU').format(selectedDay);

    return Column(
      children: [
        const SizedBox(
          height: 150,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svgs/i.svg"),
            const SizedBox(width: 12),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Занятий не найдено\n',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF71727A),
                    ),
                  ),
                  TextSpan(
                    text: "на $currentMonth",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF71727A),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  bool isSameDay(DateTime first, DateTime second) {
    return first.day == second.day &&
        first.month == second.month &&
        first.year == second.year;
  }
}
