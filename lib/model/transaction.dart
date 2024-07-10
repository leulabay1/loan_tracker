import 'package:hive/hive.dart';
part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String reason;

  @HiveField(2)
  final num amount;

  @HiveField(3)
  final DateTime date;

  Transaction(
      {required this.id,
      required this.reason,
      required this.amount,
      required this.date});
}
