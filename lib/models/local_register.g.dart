// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_register.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalRegisterAdapter extends TypeAdapter<LocalRegister> {
  @override
  final int typeId = 0;

  @override
  LocalRegister read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalRegister(
      registerType: fields[0] as String,
      data: (fields[1] as Map).cast<String, dynamic>(),
      status: fields[2] as RegisterStatus,
      registerImagePath: fields[3] as String?,
      registerImagePath2: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalRegister obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.registerType)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.registerImagePath)
      ..writeByte(4)
      ..write(obj.registerImagePath2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalRegisterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
