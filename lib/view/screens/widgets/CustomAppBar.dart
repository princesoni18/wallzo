import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:180,
      
      //color:Color(0xFF101726),
      child: RichText(
        textAlign: TextAlign.center,
        text:   TextSpan(
          text: "WALL", style: TextStyle(color:Color(0xFF101726),
          fontFamily:GoogleFonts.lato().fontFamily,
          
          fontWeight: FontWeight.bold,
          
          fontSize: 28),
          children: [
            TextSpan(
                text: ' ZO',
                style: TextStyle(
                
                  color: Color(0xFF43D9BD),
                  fontWeight: FontWeight.bold,
                 
                  
                  fontSize: 28
                ))
          ],
        ),
      ),
    );
  }
}
