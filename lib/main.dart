import 'package:widgets/api/api_service.dart';
import 'package:widgets/api/config.dart';
import 'package:calendar_gymatech/cubit/schedule_cubit.dart';
import 'package:calendar_gymatech/filter_page.dart';
import 'package:calendar_gymatech/widgets/calendar.dart';
import 'package:calendar_gymatech/widgets/schedule_element.dart';
import 'package:widgets/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:widgets/custom_tag.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.load();
  await ApiService().setBaseUrl(Config.baseUrl);
  initializeDateFormatting('ru_RU');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ScheduleCubit()..loadSchedule(),
        ),
        // Другие провайдеры
      ],
      child: const MyApp(),
    ),
  );
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
      home: const MainPage(),
    );
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
                      return Column(
                        children: List.generate(
                          3,
                          (index) => ScheduleElement(
                            date: DateTime.now(),
                            gtoName: '',
                            trainerName: '',
                            description: '',
                            timeTag: const CustomTag(text: Text("")),
                            variant: ScheduleVariant.skeleton,
                          ),
                        ),
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
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: widget,
                            );
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
