import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/my_user.dart';
import '../../../../domain/repositories/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      final bool isValidEmail = EmailValidator.validate(event.email);
      if (event.email.isEmpty || event.password.isEmpty || event.user.name.isEmpty) {
        emit(const SignUpFailure('Vui lòng điền đầy đủ thông tin'));
      }
      if (isValidEmail) {
        try {
          MyUser user = await _userRepository.signUp(event.user, event.password);
          await _userRepository.setUserData(user);
          emit(SignUpSuccess());
        } catch (e) {
          emit(SignUpFailure(e.toString()));
        }
      } else {
        emit(const SignUpFailure('Email không hợp lệ'));
      }
    });

    on<SignUpWithGoogle>((event, emit) async {
      emit(SignUpProcess());
      try {
        MyUser user = await _userRepository.signInWithGoogle();
        await _userRepository.setUserData(user);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure(e.toString()));
      }
    });
  }
}
