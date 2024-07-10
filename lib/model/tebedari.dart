import 'package:hive/hive.dart';
part 'tebedari.g.dart';

@HiveType(typeId: 1)
class Tebedari {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  double debit;

  @HiveField(3)
  double credit;

  @HiveField(4)
  String lastReason;

  @HiveField(5)
  List<String>? transactions;

  Tebedari(
      {required this.id,
      required this.name,
      this.debit = 0,
      this.credit = 0,
      this.lastReason = '',
      this.transactions});

  addTransaction(String transactionId, num amount, String reason) {
    if (transactions == null) {
      transactions = List.empty(growable: true);
    }
    transactions!.add(transactionId);
    lastReason = reason;
    if (amount > 0) {
      credit += amount;
    } else {
      debit += -1 * amount;
    }
  }

  removeTransaction(String transactionId, num amount) {
    transactions!.remove(transactionId);

    if (amount > 0) {
      credit -= amount;
    } else {
      debit -= -1 * amount;
    }
  }
}
