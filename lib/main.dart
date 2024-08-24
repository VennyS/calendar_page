// import 'package:calendar_gymatech/typedef.dart';
// import 'package:widgets/api/api_service.dart';
// import 'package:widgets/api/config.dart';
// import 'package:calendar_gymatech/cubit/schedule_cubit.dart';
// import 'package:calendar_gymatech/pages/filter_page.dart';
// import 'package:calendar_gymatech/widgets/calendar.dart';
// import 'package:calendar_gymatech/widgets/schedule_element.dart';
// import 'package:widgets/filter_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';
// import 'package:widgets/custom_tag.dart';
// import 'package:widgets/models/list_item.dart';
// import 'package:widgets/models/spots.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Config.load();
//   await ApiService().setBaseUrl(Config.baseUrl);
//   initializeDateFormatting('ru_RU');
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => ScheduleCubit()..loadSchedule(),
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const CalendarPage(),
//     );
//   }
// }
