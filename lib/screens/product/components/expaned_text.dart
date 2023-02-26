// ignore_for_file: unrelated_type_equality_checks, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpanedText extends StatefulWidget {
  final String text;
  const ExpanedText({Key? key, required this.text}) : super(key: key);

  @override
  _ExpanedTextState createState() => _ExpanedTextState();
}

class _ExpanedTextState extends State<ExpanedText> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;
  @override
  void initState() {
    super.initState();
    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(151, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.length == ""
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.text,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    flag ? firstHalf : widget.text,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                  child: flag
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Xem thêm",
                                style: GoogleFonts.roboto(
                                    color: Colors.blueAccent, fontSize: 16),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.blueAccent,
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Thu gọn",
                                style: GoogleFonts.roboto(
                                    color: Colors.blueAccent, fontSize: 16),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.blueAccent,
                              )
                            ],
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
