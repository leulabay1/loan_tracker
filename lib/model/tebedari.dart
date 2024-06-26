import 'package:hive/hive.dart';
part 'tebedari.g.dart';

@HiveType(typeId: 1)
class Tebedari {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double debit;

  @HiveField(3)
  final double credit;

  @HiveField(4)
  final List<String> transactions;

  Tebedari(
      {required this.id,
      required this.name,
      required this.debit,
      required this.credit,
      required this.transactions});
}
