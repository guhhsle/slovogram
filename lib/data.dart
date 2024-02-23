
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'setting.dart';

List<String> row1 = ['Č', 'Ć', 'Đ', 'E', 'R', 'T', 'U', 'I', 'O', 'P'];
List<String> row2 = ['A', 'S' ,'D' , 'F', 'G', 'H', 'J', 'K', 'L', '/'];
List<String> row3 = ['Z', 'Š', 'Ž', 'C', 'V', 'B', 'N', 'M', 'Enter'];

List<String> lat1 = ['Č', 'Ć', 'Đ', 'E', 'R', 'T', 'U', 'I', 'O', 'P'];
List<String> lat2 = ['A', 'S' ,'D' , 'F', 'G', 'H', 'J', 'K', 'L', '/'];
List<String> lat3 = ['Z', 'Š', 'Ž', 'C', 'V', 'B', 'N', 'M', 'Enter'];

List<String> cyr1 = ['Ч', 'Ћ', 'Ђ', 'Е', 'Р', 'Т', 'У', 'И', 'О', 'П'];
List<String> cyr2 = ['А', 'С' ,'Д' , 'Ф', 'Г', 'Х', 'Ј', 'К', 'Л', '/'];
List<String> cyr3 = ['З', 'Ш', 'Ж', 'Ц', 'В', 'Б', 'Н', 'М', 'Enter'];

int currentTry = 0;
bool cyr = false;
bool last = false;


Color pri = Colors.grey.shade200;
Color sec = Colors.grey.shade900;
Color ter = Colors.white;

bool multiMode = false;
late DateTime dt;
int multiTry = 0;
int points = 0;

List<Setting> settings = [];
late final Box box;
Setting currentSetting = Setting()..theme='whiteTheme'..language='latin'..triesHistory=[]..collected = ['whiteTheme', ]..maxStreak=0;



bool won = false;

int multiTime = 3;

Map<String, Color> backgroundColors = {
  'whiteTheme' : Colors.grey.shade200,
  'greenTheme' : const Color(0xFF2b875a),
  //'yellowTheme':const Color(0xFFfbf1c7),ddcfc2
  'yellowTheme':const Color(0xFFd4be98),
  'pinkTheme':const Color(0xFFFEDBD0),
  'darkTheme' : Colors.grey.shade900,
  'greyTheme':Colors.blueGrey,
  'brownTheme':const Color(0xFF292828),
  'purpleTheme':const Color(0xFF1d2733),
  'blackTheme':Colors.black,
};

Map<String, Color> textColors = {
  'whiteTheme' : Colors.grey.shade900,
  //'greenTheme' : const Color(0xFFcbe2d4),
  'greenTheme' : Colors.teal.shade900,
  //'yellowTheme': const Color(0xFF292828),  #212226
  'yellowTheme': const Color(0xFF292828),
  'pinkTheme':const Color(0xFF442C2E),
  'darkTheme' : Colors.grey.shade200,
  'greyTheme':Colors.blueGrey.shade900,
  'brownTheme':const Color(0xFFd4be98),
  'purpleTheme':const Color(0xFF906fff),
  'blackTheme':Colors.grey.shade300,
};

String wantedWord = 'MARKO';

bool showWord = false;

List<List<String>> tries = [
  [' ', ' ', ' ', ' ', ' '], 
  [' ', ' ', ' ', ' ', ' '], 
  [' ', ' ', ' ', ' ', ' '], 
  [' ', ' ', ' ', ' ', ' '], 
  [' ', ' ', ' ', ' ', ' '], 
  [' ', ' ', ' ', ' ', ' ']
];