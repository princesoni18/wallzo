
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


import 'package:google_fonts/google_fonts.dart';

import 'package:wallzo/view/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 500));
  FlutterNativeSplash.remove();
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        
        fontFamily:GoogleFonts.lato().fontFamily 
      ),
      
      
      home: HomePage()
    );
  }
}

