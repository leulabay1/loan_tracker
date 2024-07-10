import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:loan_tracker_app/model/tebedari.dart';
import 'package:loan_tracker_app/model/transaction.dart';
import 'package:uuid/uuid.dart';

class AppRepository {
  final transactionBox = Hive.box<Transaction>('transaction');
  final tebedariBox = Hive.box<Tebedari>('tebedari');
  final uuid = Uuid();
  final storage = FlutterSecureStorage();

  List<Transaction> getTransaction(String tebedariId) {
    final tebedari = tebedariBox.get(tebedariId);
    if (tebedari == null || tebedari.transactions == null) {
      return [];
    }

    List<Transaction?> transactions = tebedari!.transactions!.map((element) {
      return transactionBox.get(element);
    }).toList();

    List<Transaction> filteredTransactions = [];
    for (var element in transactions) {
      if (element != null) {
        filteredTransactions.add(element);
      }
    }

    return filteredTransactions;
  }

  Future<Transaction> addTransaction(
      String tebedariId, num amount, String reason) async {
    final transaction = Transaction(
        id: uuid.v4(), reason: reason, amount: amount, date: DateTime.now());

    await transactionBox.put(transaction.id, transaction);

    addTransactionToTebedari(tebedariId, transaction);

    return transaction;
  }

  deleteTransaction(String id, String tebedariId) async {
    final transaction = transactionBox.get(id);
    if (transaction == null) {
      return;
    }

    await removeTransactionFromTebedari(tebedariId, transaction);
    await transactionBox.delete(id);
  }

  removeTransactionFromTebedari(
      String tebedariId, Transaction transaction) async {
    final tebedari = tebedariBox.get(tebedariId);
    if (tebedari == null) {
      return;
    }

    tebedari.removeTransaction(transaction.id, transaction.amount);

    await tebedariBox.put(tebedariId, tebedari);
  }

  Future<void> addTebedari(String name) async {
    final tebedari = Tebedari(id: uuid.v4(), name: name);

    await tebedariBox.put(tebedari.id, tebedari);
  }

  Future<void> deleteTebedari(String id) async {
    await tebedariBox.delete(id);
  }

  List<Tebedari> getTebedaris(bool? complete) {
    List<Tebedari> tebedaris = tebedariBox.values.toList();

    List<Tebedari> filteredTebedaris = [];
    if (complete != null && complete) {
      filteredTebedaris =
          tebedaris.where((element) => element.credit > element.debit).toList();
    }
    if (complete != null && !complete) {
      filteredTebedaris =
          tebedaris.where((element) => element.credit < element.debit).toList();
    }

    return complete == null ? tebedaris : filteredTebedaris;
  }

  void addTransactionToTebedari(
      String tebedariId, Transaction transaction) async {
    Tebedari? tebedari = tebedariBox.get(tebedariId);

    if (tebedari == null) return null;

    tebedari.addTransaction(
        transaction.id, transaction.amount, transaction.reason);
    await tebedariBox.put(tebedari.id, tebedari);
  }

  setPassword(String password) async {
    await storage.write(key: 'password', value: password);
  }

  Future<String?> getPassword() async {
    return await storage.read(key: 'password');
  }

  Future<bool> checkPassword(String password) async {
    final savedPassword = await getPassword();
    return savedPassword == password;
  }

  Future<void> deletePassword() async {
    await storage.delete(key: 'password');
  }
}
