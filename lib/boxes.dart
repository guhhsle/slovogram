import 'package:hive/hive.dart';

import 'setting.dart';

class Boxes{
  static Box<Setting> getSettings(){
    return Hive.box<Setting>('settings');
  }
}