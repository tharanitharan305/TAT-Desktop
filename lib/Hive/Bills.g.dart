// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Bills.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillsAdapter extends TypeAdapter<Bills> {
  @override
  final int typeId = 0;

  @override
  Bills read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bills(
      bill: fields[0] as File,
    );
  }

  @override
  void write(BinaryWriter writer, Bills obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.bill);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
