import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_tracker_app/bloc/tebedari_bloc/tebedari_bloc.dart';
import 'package:loan_tracker_app/model/transaction.dart';
import 'package:loan_tracker_app/respository/app_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final AppRepository appRepository;
  final TebedariBloc tebedariBloc;
  TransactionBloc({
    required this.appRepository,
    required this.tebedariBloc,
  }) : super(TransactionIntail()) {
    on<AddTransaction>((event, emit) async {
      emit(TransactionLoading());
      await appRepository.addTransaction(
          event.tebedariId, event.amount, event.reason);
      tebedariBloc.add(LoadTebedaris());
    });

    on<LoadTransactions>((event, emit) {
      emit(TransactionLoading());
      final transactions = appRepository.getTransaction(event.tebedariId);
      emit(TransactionLoaded(transaction: transactions));
    });

    on<DeleteTransaction>(((event, emit) async {
      await appRepository.deleteTransaction(event.id, event.tebedariId);
      tebedariBloc.add(LoadTebedaris());
    }));
  }
}
