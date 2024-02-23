import 'package:flutter/material.dart';

import 'data.dart';

class PageAbout extends StatefulWidget {
  const PageAbout({ Key? key }) : super(key: key);

  @override
  _PageAboutState createState() => _PageAboutState();
}

class _PageAboutState extends State<PageAbout> {

  Map<String, String> latMap = {
    'Verzija' : '1.0.0',
    'Marko' : ' '
  };

  Map<String, String> cyrMap = {
    'Верзија':'1.0.0',
    'Марко' : ' '
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: sec,
        foregroundColor: pri,
        title: Text(
          cyr?'Информације':'Informacije'
        ),
      ),
      backgroundColor: pri,
      body: ListView.builder(
        itemCount: latMap.length,
        itemBuilder: (context, index){
          return Card(
            elevation: 6,
            shadowColor: sec,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            color: sec,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              width: double.infinity,
              height: 50,
              child: Row(
                children: [
                  Text(
                    cyr?cyrMap.keys.elementAt(index):latMap.keys.elementAt(index),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: pri
                    )
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        cyr?cyrMap.values.elementAt(index):latMap.values.elementAt(index),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: pri
                        )
                      )
                    )
                  )
                ],
              )
            )
          );
        }
      )
    );
  }
}