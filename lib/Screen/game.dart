import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictaktoe/constants/colors.dart';

class GameScreen extends StatefulWidget{
  const GameScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen>{
  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  List<int> matchedIndexes = [];
  int attempts = 0;

  String resultDeclaration = '';
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool winnerFound = false;

  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;

  bool restart_enable = false;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                flex: 1,
              child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Player O', style: customFontWhite,),
                          Text(oScore.toString(), style: customFontWhite,),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Player X', style: customFontWhite,),
                          Text(xScore.toString(), style: customFontWhite,),
                        ],
                      ),
                    ],
                  )),
            ),
            Expanded(
                flex: 3,
                child: GridView.builder(itemCount: displayXO.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (BuildContext context,int index) {
                  return GestureDetector(
                    onTap: (){
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: matchedIndexes.contains(index) ? MainColor.accentColor : MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 5,color: MainColor.primaryColor),
                      ),
                      child: Center(
                        child: Text(displayXO[index],style: GoogleFonts.coiny(textStyle: TextStyle(fontSize: 64,color: MainColor.primaryColor)),),
                      ),
                    ),
                  );
                },),
            ),
            Expanded(flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(resultDeclaration,style: customFontWhite,),
                      SizedBox(height: 18,),
                      _buildTimer(),
                      if(restart_enable==true)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,),
                          child: Text("Restart", style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          onPressed: (){
                            setState(() {
                              oScore = 0;
                              xScore = 0;
                              startTimer();
                              _clearBoard();
                              matchedIndexes = [];
                              restart_enable = false;
                            });
                          },
                        ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
  void _tapped(int index){
    final isRunning = timer == null ? false : timer!.isActive;
    if(isRunning) {
      setState(() {
        if (oTurn && displayXO[index] == '') {
          displayXO[index] = 'O';
          oTurn = !oTurn;
          filledBoxes++;
        } else if (!oTurn && displayXO[index] == '') {
          displayXO[index] = 'X';
          oTurn = !oTurn;
          filledBoxes++;
        }
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    // check 1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([1,2,3]);
        stopTimer();
        _updateScore(displayXO[0]);
        restart_enable = !restart_enable;
      });
    }

    // check 2nd row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[3] + ' Wins!';
        matchedIndexes.addAll([3,4,5]);
        stopTimer();
        _updateScore(displayXO[3]);
        restart_enable = !restart_enable;
      });
    }

    // check 3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins!';
        matchedIndexes.addAll([6,7,8]);
        stopTimer();
        _updateScore(displayXO[6]);
        restart_enable = !restart_enable;
      });
    }

    // check 1st column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0,3,6]);
        stopTimer();
        _updateScore(displayXO[0]);
        restart_enable = !restart_enable;
      });
    }

    // check 2nd column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[1] + ' Wins!';
        matchedIndexes.addAll([1,4,7]);
        stopTimer();
        _updateScore(displayXO[1]);
        restart_enable = !restart_enable;
      });
    }

    // check 3rd column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[2] + ' Wins!';
        matchedIndexes.addAll([2,5,8]);
        stopTimer();
        _updateScore(displayXO[2]);
        restart_enable = !restart_enable;
      });
    }

    // check diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0,4,8]);
        stopTimer();
        _updateScore(displayXO[0]);
        restart_enable = !restart_enable;
      });
    }

    // check diagonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins!';
        matchedIndexes.addAll([6,4,2]);
        stopTimer();
        _updateScore(displayXO[6]);
        restart_enable = !restart_enable;
      });
    }

    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Nobody Wins!';
      });
    }
  }
  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
      winnerFound = true;
    } else if (winner == 'X') {
      xScore++;
      winnerFound = true;
    }
  }
  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      resultDeclaration = '';
      filledBoxes = 0;
    });
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1 - seconds / maxSeconds,
            valueColor: AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 8,
            backgroundColor: MainColor.accentColor,
          ),
          Center(
            child: Text('$seconds',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 50,
              ),
            ),
          ),
        ],
      ),
    )
        : ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
      onPressed: () {
        startTimer();
        _clearBoard();
        attempts++;
        matchedIndexes = [];
        restart_enable = false;
      },
      child: Text(
        attempts == 0 ? 'Start' : 'Play Again!',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

}