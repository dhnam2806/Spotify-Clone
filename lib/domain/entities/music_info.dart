import 'package:flutter/material.dart';

class MusicInfo {
  Duration? duration;
  String trackId;
  String? artistName;
  String? songName;
  String? songImage;
  String? artistImage;
  Color? songColor;

  MusicInfo(
      {this.duration,
      required this.trackId,
      this.artistName,
      this.songName,
      this.songImage,
      this.artistImage,
      this.songColor});
}