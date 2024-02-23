
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:slovogram/base.dart';
import 'package:slovogram/data.dart';
import 'package:slovogram/qr_scan.dart';
import 'functions.dart';
import 'provider.dart';



List<String> multiWords = [];


void scannedMultiWords(String str){
  currentTry = 0;
  points=0;
  multiWords.clear();
  last = false;
  tries = [
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' ']
  ];

  for (var i = 0; i < 20; i++) {
    multiWords.add(str.substring(i*5+1, (i+1)*5+1));
  }
  try {
    multiTime= int.parse(str[0]);
    
  // ignore: empty_catches
  } catch (e) {
  }

  if(cyr){
    wantedWord = toCyr(multiWords[0].toUpperCase());
  }else{
    wantedWord = multiWords[0].toUpperCase();
  }
  showWord = false;
}

void nextWord(String word){
  currentTry = 0;
  last = false;
  tries = [
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' ']
  ];
  if(cyr){
    wantedWord = toCyr(word.toUpperCase());
  }else{
    wantedWord = word.toUpperCase();
  }
  showWord = false;
}


List<String> multiWords2 = [];

String makeWords(){
  Random random = Random();
  multiWords2.clear();
  for (var i = 0; i < 20; i++) {
    multiWords2.add(words[random.nextInt(words.length)]);
  }
  print(multiTime.toString()+multiWords2.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '').replaceAll(' ', ''));
  return multiTime.toString()+multiWords2.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '').replaceAll(' ', '');
}

void showQR(BuildContext context){
  showModalBottomSheet(
    backgroundColor: pri,
    elevation: 32,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(36)
      )
    ),
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState ) {
          return Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.05, bottom: 16),
            decoration: BoxDecoration(
              color: pri,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(36)
              )
            ),
            child: Wrap(
              children: [
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.04),
                      child: QrImage(
                        data: makeWords(),
                        version: QrVersions.auto,
                        size: MediaQuery.of(context).size.width*0.8,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Card(
                      elevation: 6,
                      shadowColor: sec,
                      margin: const EdgeInsets.only(left: 16, right: 8, top: 32),
                      color: sec,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: (){
                          showCodeInfoSheet(context);
                        },
                        icon: Icon(
                          Icons.info_outline,
                          color: pri,
                        ),
                      )
                    ),
                    Expanded(
                      child: Card(
                        elevation: 6,
                        shadowColor: sec,
                        margin: const EdgeInsets.only(left: 8, right: 8, top: 32),
                        color: sec,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState((){
                              multiTime = (multiTime+2)%10;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            alignment: Alignment.centerRight,
                            height: 50,
                            child: Center(
                              child: Text(
                                cyr?(multiTime.toString()+'мин') : (multiTime.toString()+'min'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: pri
                                ),
                              ),
                            )
                          ),
                        )
                      ),
                    ),
                    Expanded(
                      child: Card(
                        elevation: 6,
                        shadowColor: sec,
                        margin: const EdgeInsets.only(left: 8, right: 16, top: 32),
                        color: sec,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScan()));
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            height: 50,
                            child: Center(
                              child: Text(
                                cyr?'Скенирај' : 'Skeniraj',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: pri
                                ),
                              ),
                            )
                          ),
                        )
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 6,
                  shadowColor: sec,
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  color: sec,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                       points=0;
                      multiWords=multiWords2.toList();
                      nextWord(multiWords[0]);
                      multiMode = true;
                       dt = DateTime.now();
                      context.read<Provider0>().refresh();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Center(
                        child: Text(
                          cyr?'Започни' : 'Započni',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: pri
                          ),
                        ),
                      )
                    ),
                  )
                ),
              ],
            )
          );
        }
      );
    }
  );
}
void showCodeInfoSheet(BuildContext context){
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: pri,
    elevation: 32,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(36)
      )
    ),
    context: context,
    builder: (context) {
      List<String> cyrInfoRows = [
        'Партија траје '+multiTime.toString()+'мин',
        'Бодованје на основу погођених слова',
        'Бонус поени зависно од броја покушаја',
        '8 поена мање за 6 промашених речи',
        'Број могућих комбинација: 1,735,572,809,472,414,700,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000'
      ];

      List<String> latInfoRows = [
        'Partija traje '+multiTime.toString()+'min',
        'Bodovanje na osnovu pogođenih slova',
        'Bonus poeni zavisno od broja pokušaja',
        '8 poena manje za 6 promašenih reči',
        'Broj mogućih kombinacija: 1,735,572,809,472,414,700,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000'
      ];
      return Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.05, bottom: 16),
            decoration: BoxDecoration(
              color: pri,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(36)
              )
            ),
            child: Wrap(
              children: [
                ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: cyrInfoRows.length,
            itemBuilder: (context, index){
              return Card(
                elevation: 6,
                shadowColor: sec,
                margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                color: sec,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 50,
                    minWidth: double.infinity,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                    child: Center(
                      child: Text(
                        cyr?cyrInfoRows[index]:latInfoRows[index],
                        style: TextStyle(
                          color: pri,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          )
              ]
        )
      );
    }
  );
}