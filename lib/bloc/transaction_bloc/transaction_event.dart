part of 'transaction_bloc.dart';

sealed class TransactionEvent {}

final class AddTransaction extends TransactionEvent {
  final String reason;
  final num amount;
  final String tebedariId;

  AddTransaction(
      {required this.reason, required this.amount, required this.tebedariId});
}

final class LoadTransactions extends TransactionEvent {
  final String tebedariId;

  LoadTransactions({required this.tebedariId});
}

final class DeleteTransaction extends TransactionEvent {
  final String id;
  final String tebedariId;

  DeleteTransaction({required this.id, required this.tebedariId});
}
