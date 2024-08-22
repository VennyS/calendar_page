import 'package:calendar_gymatech/filter_page.dart';
import 'package:calendar_gymatech/widgets/calendar.dart';
import 'package:calendar_gymatech/widgets/filter.dart';
import 'package:calendar_gymatech/widgets/schedule_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:widgets/custom_tag.dart';

void main() {
  initializeDateFormatting('ru_Ru');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const MainPage());
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
            const SizedBox(
              width: 16,
            )
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
          child: Column(
            children: [
              const CalendarCard(),
              const SizedBox(
                height: 12,
              ),
              ScheduleElement(
                  variant: ScheduleVariant.standart,
                  gtoName: "Аэробика",
                  trainerName: "Василий Кошкин",
                  description: "Тренер",
                  timeTag: CustomTag(
                    leftIcon: SvgPicture.asset(
                      "assets/svgs/clock.svg",
                    ),
                    showleftIcon: true,
                    disabledBackgroundColor: const Color(0xFFD6B5FF),
                    text: Text(
                      "20:00-21:00",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ))
            ],
          ),
        ));
  }

  // TODO:
  Widget nothingWasFound() {
    return Row(
      children: [
        SvgPicture.asset("assets/svgs/i.svg"),
        const SizedBox(
          width: 12,
        ),
      ],
    );
  }
}
