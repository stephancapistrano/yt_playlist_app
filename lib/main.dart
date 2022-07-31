import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:project_5_youtube_playlist/api.dart';
import 'package:project_5_youtube_playlist/blocs/favorite_bloc.dart';
import 'package:project_5_youtube_playlist/blocs/video_bloc.dart';
import 'package:project_5_youtube_playlist/screens/home.dart';

void main() {
  Api api = Api();
  api.search("one piece");

  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
        bloc: FavoriteBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          
          title: "Playlist",
          home: Home(),
        ),
      )
    );
  }
}