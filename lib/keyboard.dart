import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:slovogram/functions.dart';
import 'package:slovogram/key.dart';
import 'package:slovogram/provider.dart';

import 'data.dart';

class Keyboard extends StatefulWidget {
  const Keyboard({ Key? key }) : super(key: key);

  @override
  _KeyboardState createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  @override
  Widget build(BuildContext context) {
    return context.watch<Provider0>().getLol?SizedBox(
      height: MediaQuery.of(context).orientation == Orientation.portrait?(3*MediaQuery.of(context).size.width/5.5):MediaQuery.of(context).size.height/1.5,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.width/5.5:MediaQuery.of(context).size.height/5,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: row1.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      HapticFeedback.lightImpact();
                      insert(row1[index]);
                      context.read<Provider0>().refresh();
                    },
                    child: KeyWord(
                      word: row1[index]
                    )
                  );
                }
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.width/5.5:MediaQuery.of(context).size.height/5,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: row2.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  if(row2[index]=='/'){
                    return InkWell(
                      onTap: (){
                        HapticFeedback.lightImpact();
                        backSpace();
                        context.read<Provider0>().refresh();
                      },
                      child: const KeyDelete()
                    );
                  }else{
                    return InkWell(
                      onTap: (){
                        HapticFeedback.lightImpact();
                        insert(row2[index]);
                        context.read<Provider0>().refresh();
                      },
                      child: KeyWord(
                        word: row2[index]
                      )
                    );
                  }
                }
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.width/5.5:MediaQuery.of(context).size.height/5,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: row3.length,
                itemBuilder: (context, index){
                  if(row3[index]=='Enter'){
                    return InkWell(
                      onTap: (){
                        if(!showWord){
                          HapticFeedback.lightImpact();
                          context.read<Provider0>().newLine(context);
                        }
                      },
                      child: const KeyEnter()
                    );
                  }else{
                    return InkWell(
                      onTap: (){
                        HapticFeedback.lightImpact();
                        insert(row3[index]);
                        context.read<Provider0>().refresh();
                      },
                      child: KeyWord(
                        word: row3[index]
                      )
                    );
                  }
                }
              ),
            ),
          ),
        ],
      )
    ):Container();
  }
}

