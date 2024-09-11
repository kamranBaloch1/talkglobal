import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:talkglobal/utility/language_dropdown.dart';
import 'package:talkglobal/utility/translate_from.dart';
import 'package:talkglobal/utility/translate_to.dart';

class PromptScreen extends StatefulWidget {
  final VoidCallback showHomeScreen;

  const PromptScreen({super.key, required this.showHomeScreen});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  String? selectedCountryFrom;
  String? selectedCountryTo;
  TextEditingController controller = TextEditingController();
  String _translatedText = '';
  bool _loading = false;

  void _handleLanguageChangeFrom(String? newCountry) {
    setState(() {
      selectedCountryFrom = newCountry;
    });
  }

  void _handleLanguageChangeTo(String? newCountry) {
    setState(() {
      selectedCountryTo = newCountry;
    });
  }

  Future<void> _translateText() async {
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null) {
      print('No API_KEY environment variable');
      return;
    }

    final inputText = controller.text;
    final fromLang = selectedCountryFrom;
    final toLang = selectedCountryTo;

    if (inputText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('What are you translating?')),
      );
      return;
    }

    if (fromLang == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('What language are you translating from?')),
      );
      return;
    }

    if (toLang == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('What language are you translating to?')),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final content = [
        Content.text('Translate only "$inputText" from $fromLang to $toLang')
      ];
      final response = await model.generateContent(content);

      setState(() {
        _translatedText = response.text!;
      });

      print('$_translatedText');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to translate text')),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50.h, left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xFF6D1B7B).withOpacity(0.8),
                      width: 0.2.w,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Text Translation",
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFF000000),
                      ),
                    ),
                    const Icon(
                      Icons.text_fields,
                      color: Color(0xFF000000),
                      size: 24.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Row(
                  children: [
                    Expanded(
                      child: LanguageDropdown(
                        onLanguageChanged: _handleLanguageChangeFrom,
                     
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Icon(
                      Icons.swap_horiz_rounded,
                      color: const Color(0xFF6D1B7B).withOpacity(0.3),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: LanguageDropdown(
                        onLanguageChanged: _handleLanguageChangeTo,
                      
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          height: 1.6,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Translate From ',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFF000000),
                            ),
                          ),
                          if (selectedCountryFrom != null)
                            TextSpan(
                              text: '$selectedCountryFrom',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF000000),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Container(
                  width: double.infinity,
                  height: 223.h,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    color: const Color(0xFFFFFFFF),
                    border: Border.all(
                      color: const Color(0xFF6D1B7B).withOpacity(0.8),
                      width: 0.2.w,
                    ),
                  ),
                  child: TranslateFrom(controller: controller),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          height: 1.6,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Translate To ',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFF000000),
                            ),
                          ),
                          if (selectedCountryTo != null)
                            TextSpan(
                              text: '$selectedCountryTo',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF000000),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Container(
                  width: double.infinity,
                  height: 223.h,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    color: const Color(0xFFFFFFFF),
                    border: Border.all(
                      color: const Color(0xFF6D1B7B).withOpacity(0.8),
                      width: 0.2.w,
                    ),
                  ),
                  child: _loading
                      ? Center(
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6D1B7B).withOpacity(0.8),
                              shape: BoxShape.circle,
                            ),
                            child: const CircularProgressIndicator(),
                          ),
                        )
                      : TranslateTo(translatedText: _translatedText),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: ElevatedButton(
                  onPressed: _translateText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6D1B7B),
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                  ),
                  child: Text(
                    'Translate',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
