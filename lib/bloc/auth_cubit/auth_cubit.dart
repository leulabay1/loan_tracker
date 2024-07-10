import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_tracker_app/respository/app_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AppRepository appRepository;
  AuthCubit({required this.appRepository}) : super(AuthInitial());

  void check() async {
    String? value = await appRepository.getPassword();
    if (value == null) {
      emit(Authenticated());
    }
  }

  void login(String password) async {
    emit(Authenticating());
    bool value = await appRepository.checkPassword(password);
    if (value) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  void logout() {
    emit(AuthInitial());
  }

  void changePassword(String password) {
    appRepository.setPassword(password);
  }

  void deletePassword() {
    appRepository.deletePassword();
  }
}
