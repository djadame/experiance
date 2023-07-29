import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
class Big_Text extends StatefulWidget {
  final Color color;
  final String text;
  double size;
  TextOverflow overflow;
  Big_Text({Key? key,  this.color = const Color(0xFF332d2b),
    required this.text,
    this.size=20,
    this.overflow=TextOverflow.ellipsis}): super(key :key);

  @override
  State<Big_Text> createState() => _BigTextState();
}

class _BigTextState extends State<Big_Text> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      maxLines: 1,
      overflow: widget.overflow,
      style: GoogleFonts.roboto(
        color:widget.color,
        fontSize: widget.size,
        fontWeight: FontWeight.w400,
      ),

    );
  }
}
