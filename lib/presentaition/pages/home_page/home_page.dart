import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_clone/core/config/app_constant.dart';
import 'package:spotify_clone/timer/token_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final credentials = SpotifyApiCredentials(
      AppConstant.clientId,
      AppConstant.clientSecret,
      accessToken: TokenManager().token, // Lấy access_token từ TokenManager
    );
    final spotify = SpotifyApi(credentials);
    print(credentials.accessToken);
    spotify.tracks.get('44sYmL97Lv8mEbzgANFkPD').then((track) {
      print('Name: ${track.name}');
      print('Album: ${track.album?.name}');
      print('Artist: ${track.artists?.map((a) => a.name).join(', ')}');
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GestureDetector(
              onTap: () async {
                Timer(const Duration(seconds: 3), () {
                  final tokenManager = TokenManager();
                  tokenManager.stopFetchingToken();
                });
                await FirebaseAuth.instance.signOut();
              },
              child: Text('Home Page')),
        ),
      ),
    );
  }
}
