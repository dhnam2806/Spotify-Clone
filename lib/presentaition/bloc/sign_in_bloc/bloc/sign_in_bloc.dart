import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/repositories/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  SignInBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      final bool isValidEmail = EmailValidator.validate(event.email);
      if (isValidEmail) {
        if (event.email.isEmpty || event.password.isEmpty) {
          emit(const SignInFailure(message: 'Vui lòng điền đầy đủ thông tin'));
        }
        try {
          await _userRepository.signIn(event.email, event.password);
          emit(const SignInSuccess('Đăng nhập thành công'));
        } catch (e) {
          log(e.toString());
          emit(const SignInFailure(message: 'Đăng nhập thất bại'));
        }
      } else {
        emit(const SignInFailure(message: 'Email không hợp lệ'));
      }
    });
    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
    });
  }
}
