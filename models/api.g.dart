// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FrappeApiAdapter extends TypeAdapter<FrappeApi> {
  @override
  final int typeId = 0;

  @override
  FrappeApi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FrappeApi(
      key: fields[0] as String,
      secret: fields[1] as String,
      domain: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FrappeApi obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.secret)
      ..writeByte(2)
      ..write(obj.domain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FrappeApiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
