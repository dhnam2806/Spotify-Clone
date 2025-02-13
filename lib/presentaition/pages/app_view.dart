import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/presentaition/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:spotify_clone/presentaition/pages/bottom_nav_bar_widget.dart';
import 'package:spotify_clone/presentaition/pages/home_page/home_page/home_page.dart';

import '../bloc/authentication_bloc/bloc/authentication_bloc.dart';
import '../bloc/my_user_bloc/bloc/my_user_bloc.dart';
import '../bloc/sign_in_bloc/bloc/sign_in_bloc.dart';
import '../bloc/update_user_info/bloc/update_user_info_bloc.dart';
import 'authen/get_started_page.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muzik',
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SignInBloc(userRepository: context.read<AuthenticationBloc>().userRepository),
              ),
              BlocProvider(
                create: (context) =>
                    UpdateUserInfoBloc(userRepository: context.read<AuthenticationBloc>().userRepository),
              ),
              BlocProvider(
                create: (context) => MyUserBloc(myUserRepository: context.read<AuthenticationBloc>().userRepository)
                  ..add(GetMyUser(myUserId: context.read<AuthenticationBloc>().state.user!.uid)),
              ),
              BlocProvider(create: (context) => HomeBloc()..add(HomeInitialEvent())),
            ],
            child: const GNavBar(),
          );
        } else {
          return const GetStartedPage();
        }
      }),
    );
  }
}
