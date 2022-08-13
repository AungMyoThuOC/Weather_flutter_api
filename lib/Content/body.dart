import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'imagewidget.dart';
import 'package:http/http.dart ' as http;
import 'dart:convert';

class BodyWidget extends StatefulWidget {
  const BodyWidget({Key? key}) : super(key: key);


  @override
  // ignore: library_private_types_in_public_api
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height.toDouble();
    double width = size.width.toDouble();
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            child: Image.network(
              background,
              height: height / 3,
              width: width,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: height / 7,
            left: width / 3.5,
            child: Container(
              child: Stack(
                children: [
                  Positioned(
                    top: -20,
                    child: Image.asset(
                      fog,
                      height: 150,
                      width: 150,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '6',
                        style: GoogleFonts.stylish(
                          fontSize: height / 5,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 5
                      ),
                      Text(
                        'C',
                        style: GoogleFonts.stylish(
                          fontSize: height / 5,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height / 1.8,
            left: 50,
            child: Text(
              'Weather Forcast',
              style: smallText.copyWith(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
          ),
          Positioned(
            top: height / 1.6,
            left: 20,
            child: Container(
              child: Row(
                children: [
                  CustomCard(
                    temp: '17',
                    image: rainy,
                    mode: 'Rainy',
                  ),
                  SizedBox(width: 10),
                  CustomCard(
                    temp: '34',
                    image: sun,
                    mode: 'Sunny',
                  ),
                  SizedBox(width: 10),
                  CustomCard(
                    temp: '12',
                    image: cloudy,
                    mode: 'Rainy',
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.image,
    required this.temp,
    required this.mode,
  }) : super(key: key);
  final String image;
  final String temp;
  final String mode;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(17),
      ),
      height: 150,
      width: 150,
      child: Column(
        children: [
          Image.asset(
            image,
            height: 70,
            width: 100,
            fit: BoxFit.cover,
          ),
          Text(
            mode,
            style: smallText,
          ),
          Text(
            temp,
            style: smallText,
          ),
        ],
      ),
    );
  }
}