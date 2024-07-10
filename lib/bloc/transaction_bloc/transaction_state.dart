part of 'transaction_bloc.dart';

class TransactionState {}

class TransactionIntail extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transaction;
  TransactionLoaded({required this.transaction});
}
