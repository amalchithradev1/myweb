import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
   final TextAlign ?alignment;
  final String ?text;
  final Color? color;
  final double? size;
  final FontWeight? fw;
  final Size sSize;
  const TextWidget({
    super.key,
    required this.sSize,
    this.size,this.text, this.color,this.fw,this.alignment
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      textAlign: sSize.width < 600 && alignment!=null ? alignment : null,
      style: GoogleFonts.b612(
     fontSize: size!=null?size:sSize.width * 0.040,
          color: color,
          fontWeight: fw,
        letterSpacing: 1.5
      ),
      overflow: TextOverflow.fade,
    );
  }
}