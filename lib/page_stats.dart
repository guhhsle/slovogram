import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:slovogram/data.dart';


class ChartData {
  String tryNo;
  int times;
  ChartData(this.tryNo, this.times);
}

class PageStats extends StatefulWidget {
  const PageStats({ Key? key }) : super(key: key);

  @override
  _PageStatsState createState() => _PageStatsState();
}

class _PageStatsState extends State<PageStats> {

  late List<ChartData> chartData;

  Map<String, String> latMap = {
    'Ukupan broj pobeda' : currentSetting.triesHistory.length.toString(),
    'Najbolji niz pobeda zaredom' : currentSetting.maxStreak.toString(),
    'Trenutni niz pobeda zaredom' : currentSetting.currentStreak.toString(),
    'Najbolji rezultat za 1min' : currentSetting.bestMulti[0].toString(),
    'Najbolji rezultat za 3min' : currentSetting.bestMulti[1].toString(),
    'Najbolji rezultat za 5min' : currentSetting.bestMulti[2].toString(),
    'Najbolji rezultat za 7min' : currentSetting.bestMulti[3].toString(),
    'Najbolji rezultat za 9min' : currentSetting.bestMulti[4].toString(),
  };

  Map<String, String> cyrMap = {
    'Укупан број победа' : currentSetting.triesHistory.length.toString(),
    'Најбољи низ победа заредом' : currentSetting.maxStreak.toString(),
    'Тренутни низ победа заредом' : currentSetting.currentStreak.toString(),
    'Најбољи резултат за 1мин' : currentSetting.bestMulti[0].toString(),
    'Најбољи резултат за 3мин' : currentSetting.bestMulti[1].toString(),
    'Најбољи резултат за 5мин' : currentSetting.bestMulti[2].toString(),
    'Најбољи резултат за 7мин' : currentSetting.bestMulti[3].toString(),
    'Најбољи резултат за 9мин' : currentSetting.bestMulti[4].toString(),
  };

  List<ChartData> getChartData(){
    int jedan = 0, dva = 0, tri = 0, cetri = 0, pet = 0, sest = 0;
    for (var i = 0; i < currentSetting.triesHistory.length; i++) {
      switch (currentSetting.triesHistory[i]%6) {
        case 0:
          jedan++;
          break;
        case 1:
          dva++;
          break;
        case 2:
          tri++;
          break;
        case 3:
          cetri++;
          break;
        case 4:
          pet++;
          break;
        case 5:
          sest++;
          break;
      }
    }

    final List<ChartData> _chartData = [
      ChartData(cyr?'Из прве':'Iz prve', jedan),
      ChartData(cyr?'Друге':'Druge', dva),
      ChartData(cyr?'Треће':'Treće', tri),
      ChartData(cyr?'Четврте':'Četvrte', cetri),
      ChartData(cyr?'Пете':'Pete', pet),
      ChartData(cyr?'Шесте':'Šeste', sest),
    ];

    return _chartData;
  }

  @override
  void initState() {
    chartData = getChartData();
    super.initState();
  }

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
          cyr?'Статистика':'Statistika',
        ),
      ),
      backgroundColor: pri,
      body: ListView(
        children: [
          SfCircularChart(
            legend: Legend(
              isVisible: true,
              backgroundColor: Colors.grey.shade200,
              overflowMode: LegendItemOverflowMode.wrap
            ),
            series: <CircularSeries>[
              PieSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _){
                  return data.tryNo;
                },
                yValueMapper: (ChartData data, _){
                  return data.times;
                },
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true
                ),
                explode: true,
                explodeIndex: 1
              )
            ]
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 36),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: latMap.length,
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
                  height: 50,
                  child: Row(
                    children: [
                      Text(
                        cyr?cyrMap.keys.elementAt(index):latMap.keys.elementAt(index),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColors.values.elementAt(index%backgroundColors.length)
                        )
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            cyr?cyrMap.values.elementAt(index):latMap.values.elementAt(index),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColors.values.elementAt(index%backgroundColors.length)
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
        ]
      )
    );
  }
}