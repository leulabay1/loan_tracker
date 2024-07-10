import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_tracker_app/model/tebedari.dart';
import 'package:loan_tracker_app/respository/app_repository.dart';

part 'tebedari_event.dart';
part 'tebedari_state.dart';

class TebedariBloc extends Bloc<TebedariEvent, TebedariState> {
  final AppRepository appRepository;
  TebedariBloc({
    required this.appRepository,
  }) : super(TebedariIntial()) {
    on<AddTebedari>((event, emit) async {
      emit(LoadingTebedaris());
      await appRepository.addTebedari(event.name);
      add(LoadTebedaris());
    });

    on<LoadTebedaris>((event, emit) {
      emit(LoadingTebedaris());

      final tebedaris = appRepository.getTebedaris(event.complete);
      emit(TebedarisLoaded(tebedaris: tebedaris));
    });

    on<DeleteTebedari>((event, emit) async {
      emit(LoadingTebedaris());
      await appRepository.deleteTebedari(event.id);
      add(LoadTebedaris());
    });
  }
}
