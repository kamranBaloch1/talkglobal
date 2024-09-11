import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageDropdown extends StatefulWidget {
  final ValueChanged<String?> onLanguageChanged;

  const LanguageDropdown({Key? key, required this.onLanguageChanged})
      : super(key: key);

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  final List<Map<String, String>> languageData = [
    {
      'countryLanguage': 'English - US',
      'countryImage': 'assets/images/usa.png'
    },
    {
      'countryLanguage': 'English - UK',
      'countryImage': 'assets/images/britain.png'
    },
    {'countryLanguage': 'Russian', 'countryImage': 'assets/images/russia.png'},
    {'countryLanguage': 'Balochi', 'countryImage': 'assets/images/balochi.png'}, 
    {'countryLanguage': 'German', 'countryImage': 'assets/images/germany.png'},
    {'countryLanguage': 'French', 'countryImage': 'assets/images/france.png'},
    {'countryLanguage': 'Spanish', 'countryImage': 'assets/images/spain.png'},
  ];

  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.w,top: 2.h,right: 20), 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: const Color(0xFFFFFFFF),
        border: Border.all(
          color: const Color(0xFF6D1B7B).withOpacity(0.8),
          width: 0.1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCountry,
          hint: Text(
            "Select Language",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: const Color(0xFF000000),
            ),
          ),
          icon: Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: const Color(0xFF6D1B7B).withOpacity(0.3),
            ),
          ),
          isExpanded: true, // Ensures the button takes the full width
          dropdownColor: const Color(0xFFFFFFFF),
          items: languageData.map((country) {
            return DropdownMenuItem<String>(
              value: country['countryLanguage'],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.asset(
                      country['countryImage']!,
                      width: 15.w,
                      height: 15.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    overflow: TextOverflow.fade,
                    country['countryLanguage']!,
                    style: GoogleFonts.poppins(
                      
                      fontSize: 12.sp,
                      color: selectedCountry == country['countryLanguage']
                          ? const Color(0xFF000000)
                          : const Color(0xFF6D1B7B).withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedCountry = newValue;
            });
            widget.onLanguageChanged(newValue);
          },
        ),
      ),
    );
  }
}
