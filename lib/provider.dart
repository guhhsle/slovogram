import 'package:flutter/material.dart';
import 'package:slovogram/base.dart';
import 'package:slovogram/data.dart';
import 'package:slovogram/functions2.dart';

import 'functions.dart';

class Provider0 with ChangeNotifier {

  bool get getLol => lol;

  bool lol = true;


  void refresh(){
    tries = tries;
    pri = backgroundColors[currentSetting.theme]!;
    sec = textColors[currentSetting.theme]!;
    lol = true;
    notifyListeners();
  }

  void newLine(BuildContext context){
    String rawString = tries[currentTry][0]+tries[currentTry][1]+tries[currentTry][2]+tries[currentTry][3]+tries[currentTry][4];
    String lineString = toLat(rawString).toLowerCase();
    String lineString2 = lineString[0].toUpperCase()+lineString[1]+lineString[2]+lineString[3]+lineString[4];
    if(!tries[currentTry].contains(' ')&&currentTry!=5&&(words.contains(lineString)||words.contains(lineString2))){

//TESTIRA LINIJU NIJE 5 NIJE MULTIPLEJER

      checkLine(context);
      currentTry++;
    }else if (!tries[currentTry].contains(' ')&&(words.contains(lineString)||words.contains(lineString2))&&!multiMode){

  //5 POKUSAJ NIJE MULTIPLEJER

      showWord = true;
      last = true;

      if (rawString==wantedWord) {
//5 TACNO
        won = true;
        currentSetting.triesHistory.add(currentTry);
        currentSetting.currentStreak++;
        if(currentSetting.maxStreak<currentSetting.currentStreak){
          currentSetting.maxStreak=currentSetting.currentStreak;
        }
        box.put(0, currentSetting);
      }else if(rawString!=wantedWord){
//NIJE POGODJENA IZ 5
        //loadAd(context);
        currentSetting.currentStreak=0;
        box.put(0, currentSetting);
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: 
                Container(
                  height: 64,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: sec,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      wantedWord,
                      style: TextStyle(
                        color: pri,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                )
            );
          }
        );
      }
    }else if (!tries[currentTry].contains(' ')&&(words.contains(lineString)||words.contains(lineString2))){
//5 POKUSAJA U MULTIPLEJER
      if(rawString==wantedWord){
//POGODJENA MULTI 6 POKUSAJ
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: cyr?Text(
            '"'+toCyr(lineString.toUpperCase())+'" погођена реч', 
            style: TextStyle(color: sec)
          ):Text(
            '"'+lineString.toUpperCase()+ '" pogođena reč', 
            style: TextStyle(color: sec)
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: pri,
        )
      );
      if(multiTry<20){
        multiTry++;
        nextWord(multiWords[multiTry]);
        currentTry=0;
        refresh();
      }
      points+=20;
      }else{
//NIJE POGODJENA MULTI 6 POKUSAJ
        if(multiTry<20){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: cyr?Text(
                '"'+wantedWord+'" је тачна реч', 
                style: TextStyle(color: sec)
              ):Text(
                '"'+wantedWord+ '" je tačna reč', 
                style: TextStyle(color: sec)
              ),
              duration: const Duration(seconds: 3),
              backgroundColor: pri,
            )
          );
          multiTry++;
          nextWord(multiWords[multiTry]);
          refresh();
        }
      }
      
    }
    else if(!tries[currentTry].contains(' ')){

      //NIJE U BAZI

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: cyr?Text(
            '"'+toCyr(lineString.toUpperCase())+'" није у бази речи', 
            style: TextStyle(color: sec)
          ):Text(
            '"'+lineString.toUpperCase()+ '" nije u bazi reci', 
            style: TextStyle(color: sec)
          ),
          duration: const Duration(seconds: 1),
          backgroundColor: pri,
        )
      );
    }
    lol = true;
    notifyListeners();
  }

  void checkLine(BuildContext context){
    String lineString = tries[currentTry][0]+tries[currentTry][1]+tries[currentTry][2]+tries[currentTry][3]+tries[currentTry][4];

    if (multiMode) {
      for (var i = 0; i < 5; i++) {
        for (var q = 0; q < 5; q++) {
          if (tries[currentTry][i]==wantedWord[i]) {
            points+=3;
            break;
          }else if (wantedWord.contains(tries[currentTry][i])) {
            points+=1;
            break;
          }
        }
      }
    }
    
//TACNO NIJE MULTIPLEJER 

    if(lineString==wantedWord&&!multiMode){
      won = true;
      showWord = true;
      currentSetting.triesHistory.add(currentTry);
      currentSetting.currentStreak++;
      if(currentSetting.maxStreak<currentSetting.currentStreak){
        currentSetting.maxStreak=currentSetting.currentStreak;
      }
      box.put(0, currentSetting);
    }else if(lineString==wantedWord){

//POGODJENA MULTIPLEJER

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: cyr?Text(
            '"'+toCyr(lineString.toUpperCase())+'" погођена реч', 
            style: TextStyle(color: sec)
          ):Text(
            '"'+lineString.toUpperCase()+ '" pogođena reč', 
            style: TextStyle(color: sec)
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: pri,
        )
      );
      if(multiTry<20){
        points+=(6-currentTry)*10;
        multiTry++;
        nextWord(multiWords[multiTry]); //75, 75,  
        currentTry=-1;
        refresh();
      }

    }else if (multiMode&&currentTry==5) {
      points-=8;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: cyr?Text(
            '"'+wantedWord+'" је тачна реч', 
            style: TextStyle(color: sec)
          ):Text(
            '"'+wantedWord+ '" je tačna reč', 
            style: TextStyle(color: sec)
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: pri,
        )
      );
    }

  }

  void swapType(){
    //cyr=!cyr;
    if(cyr){
      wantedWord=toCyr(wantedWord);
      row1=cyr1;
      row2=cyr2;
      row3=cyr3;
      for (var i = 0; i < 6; i++) {
        for (var q = 0; q < 5; q++) {
          tries[i][q]=toCyr(tries[i][q]);
        }
      }
      currentSetting.language='serbianCyrillic';
    }else{
      wantedWord=toLat(wantedWord);
      row1=lat1;
      row2=lat2;
      row3=lat3;
      
      for (var i = 0; i < 6; i++) {
        for (var q = 0; q < 5; q++) {
          tries[i][q]=toLat(tries[i][q]);
        }
      }
      currentSetting.language='serbianLatin';
    }
    box.put(0, currentSetting);
    refresh();
  }

  void newWord2(){
    newWord();

    refresh();
  }
}