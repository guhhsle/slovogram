import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slovogram/functions.dart';
import 'package:slovogram/provider.dart';

import 'data.dart';

class PageThemes extends StatefulWidget {
  const PageThemes({ Key? key }) : super(key: key);

  @override
  _PageThemesState createState() => _PageThemesState();
}

class _PageThemesState extends State<PageThemes> {

  final List<IconData> _iconsTheme = [
    Icons.ac_unit_rounded,
    Icons.nature_outlined,
    //Icons.wb_sunny_outlined,
    Icons.local_cafe_outlined,
    Icons.spa_outlined,
    Icons.landscape_rounded,
    Icons.filter_drama_rounded,
    Icons.light,
    Icons.star_purple500_rounded,
    Icons.nights_stay_outlined
  ];


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
          cyr?'Теме':'Teme'
        ),
      ),
      backgroundColor: pri,
      body: ListView(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: backgroundColors.length,
            itemBuilder: (context, index){
              return Card(
                elevation: 6,
                shadowColor: sec,
                margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                color: backgroundColors.values.elementAt(index),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    currentSetting.theme=backgroundColors.keys.elementAt(index);
                    box.put(0, currentSetting);
                    context.read<Provider0>().refresh();
                    refreshBar();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    height: 50,
                      child: Icon(_iconsTheme[index], color: textColors.values.elementAt(index)
                    ),
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