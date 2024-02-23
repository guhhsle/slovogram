import 'package:hive/hive.dart';
part 'setting.g.dart';

@HiveType(typeId: 0)
class Setting extends HiveObject{
  @HiveField(0)
  String theme = 'whiteTheme';

  @HiveField(1)
  String language = 'serbianLatin';

  @HiveField(2)
  List<int> triesHistory = [];

  @HiveField(3)
  int maxStreak = 0;

  @HiveField(4)
  int currentStreak = 0;

  @HiveField(5)
  List<String> collected = ['whiteTheme'];

  @HiveField(6)
  bool showAds = true;

  @HiveField(7)
  List<int> bestMulti = [0, 0, 0, 0, 0, 0];
}

//da maknem samo fajl setting.g.dart 
//flutter packages pub run build_runner build
