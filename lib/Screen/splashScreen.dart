import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictaktoe/Screen/game.dart';
import 'package:tictaktoe/constants/colors.dart';

class splashScreen extends StatefulWidget{
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GameScreen(),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        color: MainColor.primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,backgroundImage: AssetImage("images/tic-tac-toe.png"),
              ),
              Text("Tic-Tac-Toe",style: GoogleFonts.coiny(textStyle: TextStyle(color: Colors.white,letterSpacing: 3,fontSize: 35,)),
              ),
            ],
          ),
        ),
    )
    );
  }
}