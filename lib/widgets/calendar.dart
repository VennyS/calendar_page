import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CalendarCard extends StatefulWidget {
  const CalendarCard({super.key});

  @override
  State<CalendarCard> createState() => CalendarCardState();
}

class CalendarCardState extends State<CalendarCard> {
  late String currentMonth;
  late DateTime currentWeekStart;
  late DateTime minWeekStart;
  late DateTime selectedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
    currentMonth = DateFormat('MMMM', 'ru_RU').format(selectedDay);
    currentWeekStart = _getStartOfWeek(selectedDay);
    minWeekStart =
        _getStartOfWeek(selectedDay.subtract(const Duration(days: 7)));
  }

  DateTime _getStartOfWeek(DateTime date) {
    // Начало недели (понедельник)
    return date.subtract(Duration(days: date.weekday - 1));
  }

  void _moveWeek(int weeks) {
    setState(() {
      DateTime newWeekStart = currentWeekStart.add(Duration(days: weeks * 7));
      if (newWeekStart.isAfter(minWeekStart) || weeks > 0) {
        currentWeekStart = newWeekStart;
        currentMonth = DateFormat('MMMM', 'ru_RU').format(currentWeekStart);

        if (weeks > 0) {
          minWeekStart =
              _getStartOfWeek(selectedDay.subtract(const Duration(days: 7)));
        }
        selectedDay = selectedDay.add(Duration(days: weeks * 7));
      }
    });
  }

  bool _canMoveBack() {
    return currentWeekStart
        .subtract(const Duration(days: 7))
        .isAfter(minWeekStart);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFF7EEFF),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          monthPart(),
          weekList(),
        ],
      ),
    );
  }

  Widget monthPart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: SvgPicture.asset(
            "assets/svgs/arrow.svg",
            width: 18,
            colorFilter: ColorFilter.mode(
              _canMoveBack()
                  ? const Color(0xFFA03FFF)
                  : const Color(0xFFDAD0E3),
              BlendMode.srcIn,
            ),
          ),
          onPressed: _canMoveBack()
              ? () => _moveWeek(-1)
              : null, // Перейти на одну неделю назад
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
          onPressed: () => _moveWeek(1), // Перейти на одну неделю вперед
        ),
      ],
    );
  }

  Widget weekList() {
    List<Widget> days = List.generate(7, (index) {
      DateTime dateTime = currentWeekStart.add(Duration(days: index));
      int day = dateTime.day;
      List<String> weekdaysInRu = [
        "ПН",
        "ВТ",
        "СР",
        "ЧТ",
        "ПТ",
        "СБ",
        "ВС",
      ];

      return GestureDetector(
        onTap: () => setState(() {
          selectedDay = dateTime;
        }),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: determineColor(dateTime),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              Text(
                weekdaysInRu[index],
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: isDatesEqual(dateTime, selectedDay) &&
                          isDatesEqual(dateTime, DateTime.now())
                      ? const Color(0xFFA03FFF)
                      : isDatesEqual(dateTime, DateTime.now())
                          ? const Color(0xFFD6B5FF)
                          : const Color(0xFF817B89),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                day.toString(),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: isDatesEqual(dateTime, selectedDay) &&
                          isDatesEqual(dateTime, DateTime.now())
                      ? const Color(0xFFA03FFF)
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    });

    // Создаём строки с отступами между элементами
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days,
          ),
        ],
      ),
    );
  }

  bool isDatesEqual(DateTime first, DateTime second) {
    return first.day == second.day &&
        first.month == second.month &&
        first.year == second.year;
  }

  Color determineColor(DateTime date) {
    if (isDatesEqual(date, selectedDay) && isDatesEqual(date, DateTime.now())) {
      return Colors.white;
    } else if (isDatesEqual(date, selectedDay) &&
        !isDatesEqual(date, DateTime.now())) {
      return Colors.white;
    } else if (!isDatesEqual(date, selectedDay) &&
        isDatesEqual(date, DateTime.now())) {
      return const Color(0xFFA03FFF);
    } else {
      return Colors.transparent;
    }
  }
}
