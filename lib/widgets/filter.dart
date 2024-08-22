import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class filterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: Color(0xFFC5C6CC),
            )),
        child: Row(
          children: [
            SvgPicture.asset("assets/svgs/filter.svg"),
            const SizedBox(
              width: 8,
            ),
            Text(
              "фильтры",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 16 / 12,
              ),
            ),
          ],
        ));
  }
}
