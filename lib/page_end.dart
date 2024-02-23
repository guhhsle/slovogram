import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slovogram/functions.dart';
import 'package:slovogram/provider.dart';

import 'data.dart';
import 'functions2.dart';

class PageEnd extends StatefulWidget {
  const PageEnd({ Key? key }) : super(key: key);

  @override
  _PageEndState createState() => _PageEndState();
}

class _PageEndState extends State<PageEnd> {

  @override
  Widget build(BuildContext context) {
    return context.watch<Provider0>().getLol?Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: sec,
        foregroundColor: pri,
        title: Text(
          cyr?'Крај партије':'Kraj partije'
        ),
      ),
      backgroundColor: pri,
      body: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 32),
        children: [
          Card(
            elevation: 6,
            shadowColor: sec,
            margin: const EdgeInsets.all(16),
            color: sec,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width/2,
              height: 50,
              child: Center(
                child: Text(
                  cyr?(points.toString()+' поена'):(points.toString()+' poena'),
                  style: TextStyle(
                    color: pri,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
              ),
            ),
          ),
          Card(
            elevation: 6,
            shadowColor: sec,
            margin: const EdgeInsets.all(16),
            color: sec,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: (){
                Navigator.of(context).pop();
                showQR(context);
              },
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Text(
                    cyr? 'Нова партија':'Nova partija',
                    style: TextStyle(
                      color: pri,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(color: sec, thickness: 1.5),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: multiWords.length,
            itemBuilder: (context, index){
              return Card(
                elevation: 6,
                shadowColor: sec,
                margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                color: backgroundColors.values.elementAt(index%backgroundColors.length),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '#'+(index+1).toString(),
                        style: TextStyle(
                          color: textColors.values.elementAt(index%backgroundColors.length),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        cyr?toCyr(multiWords[index].toUpperCase()):multiWords[index].toUpperCase(),
                        style: TextStyle(
                          color: textColors.values.elementAt(index%backgroundColors.length),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                ),
              );
            }
          )
        ],
      ),
    ):Container();
  }
}