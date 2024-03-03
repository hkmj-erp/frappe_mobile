// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FrappeCredentialAdapter extends TypeAdapter<FrappeCredential> {
  @override
  final int typeId = 0;

  @override
  FrappeCredential read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FrappeCredential(
      key: fields[0] as String,
      secret: fields[1] as String,
      domain: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FrappeCredential obj) {
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
      other is FrappeCredentialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
