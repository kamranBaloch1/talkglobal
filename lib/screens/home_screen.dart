import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkglobal/screens/country_rectangles.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback showPromptScreen;
  const HomeScreen({super.key, required this.showPromptScreen});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image:  DecorationImage(
            image: AssetImage(
              "assets/images/worldmap.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 80.0.h, // Responsive top padding
            left: 16.0.w, // Responsive left padding
            right: 16.0.w, // Responsive right padding
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const Expanded(
                child: Center(
                  child: CountryRectangles(),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          height: 1.6,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Translate',
                            style: TextStyle(
                              fontSize: 32.0.sp, // Responsive font size
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' Every \n',
                            style: TextStyle(
                              fontSize: 32.0.sp, // Responsive font size
                              fontWeight: FontWeight.bold,
                              color:const Color(0xFF6D1B7B).withOpacity(0.3),
                            ),
                          ),
                          TextSpan(
                            text: 'Type Word \n',
                            style: TextStyle(
                              fontSize: 32.0.sp, // Responsive font size
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(height: 35.0.h), // Responsive height
                          ),
                          TextSpan(
                            text: 'Help You Communicate In \n',
                            style: TextStyle(
                              fontSize: 14.0.sp, // Responsive font size
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Different Languages',
                            style: TextStyle(
                              fontSize: 14.0.sp, // Responsive font size
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.0.h), // Responsive top padding
                      child: GestureDetector(
                        onTap: widget.showPromptScreen,
                        child: Container(
                          padding: EdgeInsets.all(8.0.w), // Responsive padding
                          decoration: BoxDecoration(
                            color:const Color(0xFF6D1B7B).withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            height: 50.0.w, // Responsive height
                            width: 50.0.w, // Responsive width
                            padding: EdgeInsets.all(2.0.w), // Responsive padding
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_forward,
                                color:const Color(0xFF6D1B7B).withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
