import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);

    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  void _onAuthLoginRequested(event, emit) async {
    try {
      emit(AuthLoading());
      final email = event.email;
      final password = event.password;
      if (password.length < 6) {
        emit(AuthFailure('Password cannot be less than 6 characters'));
        return;
      }
      await Future.delayed(const Duration(seconds: 1), () {
        emit(AuthSuccess(uid: '$email - $password'));
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthLogoutRequested(event, emit) async {
    try {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1), () {
        return emit(AuthInitial());
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
