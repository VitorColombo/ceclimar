// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterStatusAdapter extends TypeAdapter<RegisterStatus> {
  @override
  final int typeId = 1;

  @override
  RegisterStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RegisterStatus.pending;
      case 1:
        return RegisterStatus.sent;
      case 2:
        return RegisterStatus.error;
      default:
        return RegisterStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, RegisterStatus obj) {
    switch (obj) {
      case RegisterStatus.pending:
        writer.writeByte(0);
        break;
      case RegisterStatus.sent:
        writer.writeByte(1);
        break;
      case RegisterStatus.error:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
