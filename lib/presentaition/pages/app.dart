import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/presentaition/pages/app_view.dart';

import '../../domain/repositories/user_repository.dart';
import '../bloc/authentication_bloc/bloc/authentication_bloc.dart';

class MainApp extends StatelessWidget {
	final UserRepository userRepository;
  const MainApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
			providers: [
				RepositoryProvider<AuthenticationBloc>(
					create: (_) => AuthenticationBloc(
						myUserRepository: userRepository
					)
				)
			], 
			child: const MyAppView()
		);
  }
}