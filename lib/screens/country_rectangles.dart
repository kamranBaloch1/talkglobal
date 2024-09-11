import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryRectangles extends StatefulWidget {
  const CountryRectangles({super.key});

  @override
  State<CountryRectangles> createState() => _CountryRectanglesState();
}

class _CountryRectanglesState extends State<CountryRectangles> {
  final Random random = Random();

  final List<Map<String, String>> countryData = [
    {'countryName': 'USA', 'countryImage': 'assets/images/usa.png'},
    {'countryName': 'Russia', 'countryImage': 'assets/images/russia.png'},
    {'countryName': 'Balochi', 'countryImage': 'assets/images/balochi.png'},
    {'countryName': 'Germany', 'countryImage': 'assets/images/germany.png'},
    {'countryName': 'France', 'countryImage': 'assets/images/france.png'},
    {'countryName': 'China', 'countryImage': 'assets/images/china.png'},
    {'countryName': 'England', 'countryImage': 'assets/images/britain.png'},
    {'countryName': 'Saudi', 'countryImage': 'assets/images/arabic.png'},
  ];

  String? selectedCountry;
  Color? backgroundColor;

  @override
  void initState() {
    super.initState();
    _randomize();
  }

  void _randomize() {
    setState(() {
      selectedCountry =
          countryData[random.nextInt(countryData.length)]['countryName'];
      backgroundColor =
          Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _randomize();
      },
      child: Wrap(
        spacing: 8.0.w, // Responsive spacing
        runSpacing: 8.0.h, // Responsive run spacing
        children: countryData.map((country) {
          bool isSelected = country['countryName'] == selectedCountry;
          return Card(
            elevation: 4.0,
            color: isSelected ? backgroundColor : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0.r), // Responsive border radius
              side: BorderSide(
                color: isSelected
                    ? Colors.transparent
                    : Color(0xFF6D1B7B).withOpacity(0.8),
                width: 0.4.w, // Responsive border width
              ),
            ),
            child: Container(
              width: 180.0.w, // Responsive width
              padding: EdgeInsets.symmetric(
                vertical: 20.0.h, // Responsive vertical padding
                horizontal: 15.0.w, // Responsive horizontal padding
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    country['countryImage']!,
                    height: 20.0.h, // Responsive height
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 8.0.w), // Responsive spacing
                  Text(
                    country['countryName']!,
                    style: GoogleFonts.poppins(
                      fontSize: 14.0.sp, // Responsive font size
                      fontWeight: FontWeight.w300,
                      color: isSelected
                          ? Colors.white
                          : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
