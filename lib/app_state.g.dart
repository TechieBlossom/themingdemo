// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppStateAdapter extends TypeAdapter<AppState> {
  @override
  AppState read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppState()..isDarkModeOn = fields[0] as bool;
  }

  @override
  void write(BinaryWriter writer, AppState obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isDarkModeOn);
  }
}
