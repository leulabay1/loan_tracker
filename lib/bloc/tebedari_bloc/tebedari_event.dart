part of 'tebedari_bloc.dart';

sealed class TebedariEvent {}

final class AddTebedari extends TebedariEvent {
  final String name;

  AddTebedari({required this.name});
}

final class LoadTebedaris extends TebedariEvent {
  final bool? complete;
  LoadTebedaris({this.complete});
}

final class DeleteTebedari extends TebedariEvent {
  final String id;

  DeleteTebedari({required this.id});
}
