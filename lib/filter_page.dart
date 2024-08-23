import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widgets/custom_button.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Фильтры",
            style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset(
                "assets/svgs/cross.svg",
                // TODO: Поправить цвет иконки.
                colorFilter:
                    const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              )),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Очистить",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: const Color(0xFFA03FFF),
                  ),
                  textAlign: TextAlign.right,
                ))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButtonWidget(
                  text: "Применить",
                  accentColor: const Color(0xFFA03FFF),
                  variant: CustomButtonVariants.primary,
                  onPressed: () => Navigator.pop(context)),
            )));
  }
}
