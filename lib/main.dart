import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slovogram/page_end.dart';
import 'data.dart';
import 'functions.dart';
import 'functions2.dart';
import 'keyboard.dart';
import 'provider.dart';
import 'square.dart';
import 'boxes.dart';
import 'setting.dart';



//flutter build apk --split-per-abi



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SettingAdapter());
  await Hive.openBox<Setting>('settings');
  box = Boxes.getSettings();
  settings = box.values.toList().cast<Setting>();
  
  if(settings.isEmpty){
    box.add(
      Setting()
      /*..theme='whiteTheme'..language='serbianLatin'
      ..currentStreak=0..triesHistory=[]..collected = ['whiteTheme', ]
      ..maxStreak=0..showAds=true..bestMulti=[0]
      */
    );
    settings = box.values.toList().cast<Setting>();
  }
  currentSetting = settings[0];
  pri = backgroundColors[currentSetting.theme]!;
  sec = textColors[currentSetting.theme]!;
  cyr = currentSetting.language=='serbianCyrillic';
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
  }
  newWord();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Provider0()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Slovogram',
      home: HomePage(),
      //theme: ThemeData(fontFamily: 'OpenSans'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    refreshBar();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).orientation == Orientation.portrait?null:42,
        backgroundColor: sec,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        title: multiMode&&context.watch<Provider0>().getLol?Padding(
          padding: const EdgeInsets.only(right: 8),
          child: StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 1)),
            builder: (context, snapshot) {
              if((DateTime.now().subtract(Duration(minutes: dt.minute, seconds: dt.second))).minute>=multiTime){
                Future.delayed(const Duration(milliseconds: 300), () {
                  setState(() {
                    if(currentSetting.bestMulti[(multiTime-1)~/2]<points){
                      currentSetting.bestMulti[(multiTime-1)~/2]=points;
                    }
                    box.put(0, currentSetting);
                    multiMode=false;
                    multiTry=0;
                    won = true;
                     context.read<Provider0>().newWord2();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PageEnd()));
                    Future.delayed(const Duration(milliseconds: 300), () {
                      points=0;
                    });
                  });
                });
              }
              return Text(
                multiMode?DateFormat('mm : ss').format(DateTime.now().subtract(Duration(minutes: dt.minute, seconds: dt.second))):'',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: pri,
                ),
              );
            },
          ),
        ):Text(
          cyr?'Словограм':'Slovogram',
          style: TextStyle(
            color: pri,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          multiMode&&context.watch<Provider0>().getLol? Padding(
            padding: const EdgeInsets.only(right: 8),
            child: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Center(
                  child: Text(
                    points.toString(),
                    style: TextStyle(
                      color: pri,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                );
              }
            )
          ):Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: (){
                context.read<Provider0>().newWord2();
              }, 
              tooltip: cyr?'Нова партија':'Nova partija',
              icon: Icon(
                Icons.restart_alt_rounded,
                size: 26,
                color: pri,
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: (){
                showQR(context);
              }, 
              tooltip: cyr?'Више играча':'Više igrača',
              icon: Icon(
                Icons.qr_code_rounded,
                size: 26,
                color: pri,
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: (){
                showSheet(context);
              }, 
              tooltip: cyr?'Мени':'Meni',
              icon: Icon(
                Icons.menu,
                size: 26,
                color: pri,
              )
            ),
          ),
        ],
      ),
      backgroundColor: pri,
      body: MediaQuery.of(context).orientation == Orientation.portrait?Column(
        children: [
          context.watch<Provider0>().getLol?Center(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 8),
              itemCount: 6,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width/5.5,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index2){
                        return LetterBox(word: tries[index][index2], column: index, row: index2,);
                      }
                    ),
                  ),
                );
              },
            ),
          ):Container(),
          const Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Keyboard()
              ),
            ),
          ),
        ],
      ):Row(
        children: [
          context.watch<Provider0>().getLol?SizedBox(
            height: MediaQuery.of(context).size.height/1.2,
            width: MediaQuery.of(context).size.width/2.2,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 8),
              itemCount: 6,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.width/12,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context, index2){
                      return LetterBox(word: tries[index][index2], column: index, row: index2,);
                    }
                  ),
                );
              },
            ),
          ):Container(),
          const Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Keyboard()
              ),
            ),
          ),
        ],
      )
    );
  }
}