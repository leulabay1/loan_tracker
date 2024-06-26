// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tebedari.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TebedariAdapter extends TypeAdapter<Tebedari> {
  @override
  final int typeId = 1;

  @override
  Tebedari read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tebedari(
      id: fields[0] as String,
      name: fields[1] as String,
      debit: fields[2] as double,
      credit: fields[3] as double,
      transactions: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Tebedari obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.debit)
      ..writeByte(3)
      ..write(obj.credit)
      ..writeByte(4)
      ..write(obj.transactions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TebedariAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
