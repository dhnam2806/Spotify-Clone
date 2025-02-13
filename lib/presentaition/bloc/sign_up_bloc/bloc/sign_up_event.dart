part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent{
	final MyUser user;
  final String email;
	final String password;

	const SignUpRequired(this.user, this.email, this.password);
}

class SignUpWithGoogle extends SignUpEvent{
  const SignUpWithGoogle();
}