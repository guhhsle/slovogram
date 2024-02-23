import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:slovogram/base.dart';
import 'package:slovogram/data.dart';
import 'package:slovogram/page_about.dart';
import 'package:slovogram/page_stats.dart';
import 'package:slovogram/page_themes.dart';
import 'provider.dart';


void insert(String word){
  bool done = false;
    for (var q = 0; q < 5 && !done && !showWord; q++) {
      if(tries[currentTry][q]==' '){
        tries[currentTry][q]=word;
        done = true;
      }
  }
}

void backSpace(){
  bool done = false;
  for (var i = 0; i < 5 && !done && !showWord; i++) {
    if(i==4||tries[currentTry][i+1]==' '){
      tries[currentTry][i]=' ';
      done = true;
    }
  }
}

void newWord(){
  currentTry = 0;
  last = false;
  if(!won){
    currentSetting.currentStreak=0;
    box.put(0, currentSetting);
  }
  won = false;
  tries = [
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' ']
  ];
  Random random = Random();
  if(cyr){
    wantedWord = toCyr(words[random.nextInt(words.length)].toUpperCase());
  }else{
    wantedWord = words[random.nextInt(words.length)].toUpperCase();
  }
  showWord = false;
}

String toCyr(String lat){
  String cyr = lat.replaceAll('Č', 'Ч').replaceAll('Ć', 'Ћ').replaceAll('Đ', 'Ђ').replaceAll('E', 'Е').replaceAll('R', 'Р') 
    .replaceAll('T', 'Т').replaceAll('U', 'У').replaceAll('I', 'И').replaceAll('O', 'О').replaceAll('P', 'П')
    .replaceAll('A', 'А').replaceAll('S' ,'С').replaceAll('D' , 'Д').replaceAll('F', 'Ф').replaceAll('G', 'Г') 
    .replaceAll('H', 'Х').replaceAll('J', 'Ј').replaceAll('K', 'К').replaceAll('L', 'Л').replaceAll('Z', 'З').replaceAll('Š', 'Ш') 
    .replaceAll('Ž', 'Ж').replaceAll('C', 'Ц').replaceAll('V', 'В').replaceAll('B', 'Б').replaceAll('N', 'Н').replaceAll('M', 'М');
  return(cyr);
}

String toLat(String lat){
  String cyr = lat.replaceAll('Ч', 'Č').replaceAll('Ћ', 'Ć').replaceAll('Ђ', 'Đ').replaceAll('Е', 'E').replaceAll('Р', 'R') 
    .replaceAll('Т', 'T').replaceAll('У', 'U').replaceAll('И', 'I').replaceAll('О', 'O').replaceAll('П', 'P')
    .replaceAll('А', 'A').replaceAll('С' ,'S').replaceAll('Д' , 'D').replaceAll('Ф', 'F').replaceAll('Г', 'G') 
    .replaceAll('Х', 'H').replaceAll('Ј', 'J').replaceAll('К', 'K').replaceAll('Л', 'L').replaceAll('З', 'Z').replaceAll('Ш', 'Š') 
    .replaceAll('Ж', 'Ž').replaceAll('Ц', 'C').replaceAll('В', 'V').replaceAll('Б', 'B').replaceAll('Н', 'N').replaceAll('М', 'M');
  return(cyr);
}


bool grey(String word){
  bool ima = false;
  for (var i = 0; i < currentTry; i++) {
    for (var q = 0; q < 5; q++) {
      if (tries[i][q]==word&&!wantedWord.contains(word)) {
        ima = true;
      }
    }
  }
  return ima;
}

bool yellow(String word){
  bool ima = false;
  for (var i = 0; i < currentTry; i++) {
    for (var q = 0; q < 5; q++) {
      if (tries[i][q]==word&&wantedWord.contains(word)) {
        ima = true;
      }
    }
  }
  return ima;
}

bool green(String word){
  bool ima = false;
   for (var i = 0; i < currentTry; i++) {
    for (var q = 0; q < 5; q++) {
      if (tries[i][q]==word&&wantedWord[q]==word) {
        ima = true;
      }
    }
  }
  return ima;
}

void refreshBar(){
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: pri,
    )
  );
}

int countSame (String word){
  int c = 0;
  for (var i = 0; i < 5; i++) {
    if(wantedWord[i]==word){
      c++;
    }
  }
  return c;
}

void showSheet(BuildContext context){
  showModalBottomSheet(
    backgroundColor: pri,
    elevation: 32,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(36)
      )
    ),
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState ) {
          return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 8),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ListTile(
                leading: Icon(
                  Icons.format_italic,
                  color: sec,
                  size: 24,
                ),
                onTap: (){
                  setState(() {
                    cyr = !cyr;
                  });
                  context.read<Provider0>().swapType();
                },
                title: Text(
                  cyr?'Ћирилица':'Latinica',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: sec
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.palette,
                  color: sec,
                  size: 24,
                ),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PageThemes()));
                },
                title: Text(
                  cyr?'Теме':'Teme',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: sec
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.insert_chart_outlined_rounded,
                  color: sec,
                  size: 24,
                ),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PageStats()));
                },
                title: Text(
                  cyr?'Статистика':'Statistika',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: sec
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: sec,
                  size: 24,
                ),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PageAbout()));
                },
                title: Text(
                  cyr?'Информације':'Informacije',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: sec
                  ),
                ),
              ),
            ]
          );
        }
      );
    }
  );
}

