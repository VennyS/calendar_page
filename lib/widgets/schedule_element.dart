import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widgets/custom_tag.dart';

enum ScheduleVariant { standart, skeleton }

class ScheduleElement extends StatelessWidget {
  final Color? backgroundColor;
  final String gtoName;
  final String trainerName;
  final String description;
  final CustomTag timeTag;
  final ScheduleVariant variant;

  const ScheduleElement(
      {super.key,
      this.backgroundColor,
      required this.gtoName,
      required this.trainerName,
      required this.description,
      required this.timeTag,
      required this.variant});

  @override
  Widget build(BuildContext context) {
    if (variant == ScheduleVariant.standart) {
      return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: backgroundColor ?? Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 0)),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    gtoName,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  timeTag
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Image.asset("assets/pngs/avatar.png"),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trainerName,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        description,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ));
    } else {
      return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromRGBO(255, 255, 255, 1),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 0)),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 22,
                    width: MediaQuery.of(context).size.width / 3,
                    color: const Color.fromRGBO(241, 237, 245, 1),
                  ),
                  Container(
                    height: 22,
                    width: MediaQuery.of(context).size.width / 4,
                    color: const Color.fromRGBO(241, 237, 245, 1),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(241, 237, 245, 1),
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    width: MediaQuery.of(context).size.width / 10,
                    height: MediaQuery.of(context).size.width / 10,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 22,
                        width: MediaQuery.of(context).size.width / 3,
                        color: const Color.fromRGBO(241, 237, 245, 1),
                      ),
                      Container(
                        height: 22,
                        width: MediaQuery.of(context).size.width / 3,
                        color: const Color.fromRGBO(241, 237, 245, 1),
                      )
                    ],
                  )
                ],
              )
            ],
          ));
    }
  }
}
