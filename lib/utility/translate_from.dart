import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TranslateFrom extends StatefulWidget {
  final TextEditingController controller;
  const TranslateFrom({super.key, required this.controller});

  @override
  State<TranslateFrom> createState() => _TranslateFromState();
}

class _TranslateFromState extends State<TranslateFrom> {
  final FlutterTts _flutterTts = FlutterTts();
  int _wordCount = 0;
  final int _wordLimit = 500;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateWordCount);
  }

  void _updateWordCount() {
    final text = widget.controller.text;
    final wordCount = text.trim().split(RegExp(r'\s+')).length;

    setState(() {
      _wordCount = wordCount > _wordLimit ? _wordLimit : wordCount;
    });
  }

  void _handleVolumeUpTap() {
    _flutterTts.speak(widget.controller.text);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateWordCount);
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: TextFormField(
            controller: widget.controller,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: 'Have something to translate?',
              hintStyle: GoogleFonts.poppins(
                fontSize: 28.0,
                color: const Color(0xFF6D1B7B).withOpacity(0.1),
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              labelStyle: GoogleFonts.poppins(
                color: const Color(0xFF000000),
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 12.0),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: const Color(0xFF6D1B7B).withOpacity(0.8),
                width: 0.2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_wordCount/$_wordLimit words',
                style: GoogleFonts.poppins(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF000000),
                ),
              ),
              GestureDetector(
                onTap: _handleVolumeUpTap,
                child: Icon(
                  Icons.volume_up_outlined,
                  color: const Color(0xFF6D1B7B).withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
