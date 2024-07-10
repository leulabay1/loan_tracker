part of 'tebedari_bloc.dart';

class TebedariState {}

class TebedariIntial extends TebedariState {}

class LoadingTebedaris extends TebedariState {}

class TebedarisLoaded extends TebedariState {
  final List<Tebedari> tebedaris;

  TebedarisLoaded({required this.tebedaris});
}
