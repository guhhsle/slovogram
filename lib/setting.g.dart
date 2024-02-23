// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingAdapter extends TypeAdapter<Setting> {
  @override
  final int typeId = 0;

  @override
  Setting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Setting()
      ..theme = fields[0] as String
      ..language = fields[1] as String
      ..triesHistory = (fields[2] as List).cast<int>()
      ..maxStreak = fields[3] as int
      ..currentStreak = fields[4] as int
      ..collected = (fields[5] as List).cast<String>()
      ..showAds = fields[6] as bool
      ..bestMulti = (fields[7] as List).cast<int>();
  }

  @override
  void write(BinaryWriter writer, Setting obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.theme)
      ..writeByte(1)
      ..write(obj.language)
      ..writeByte(2)
      ..write(obj.triesHistory)
      ..writeByte(3)
      ..write(obj.maxStreak)
      ..writeByte(4)
      ..write(obj.currentStreak)
      ..writeByte(5)
      ..write(obj.collected)
      ..writeByte(6)
      ..write(obj.showAds)
      ..writeByte(7)
      ..write(obj.bestMulti);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
