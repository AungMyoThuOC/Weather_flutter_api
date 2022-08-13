import 'package:flutter/material.dart';
import 'imagewidget.dart';
import 'package:google_fonts/google_fonts.dart';

bool value = false;
void onChanged(bool value) {
  value = !value;
}

AppBar appBar = AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  actions: [
    Switch(
      value: value,
      onChanged: onChanged,
      inactiveTrackColor: Colors.yellow,
    ),
  ],
  title: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '8/8/2022',
        style: GoogleFonts.lato(
          fontSize: 17,
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 7
      ),
      Row(
        children: [
          const Icon(
            Icons.room,
            color: Colors.red,
            size: 20,
          ),
          const SizedBox(
            width: 5
          ),
          Text(
            'Mogok',
            style: smallText,
          ),
          Text(
            'Myanmar',
            style: smallText.copyWith(
              color: Colors.grey
            ),
          ),
        ],
      ),
    ],
  ),
);