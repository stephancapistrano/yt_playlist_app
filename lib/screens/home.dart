import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:project_5_youtube_playlist/blocs/favorite_bloc.dart';
import 'package:project_5_youtube_playlist/blocs/video_bloc.dart';
import 'package:project_5_youtube_playlist/delegates/data_search.dart';
import 'package:project_5_youtube_playlist/models/video.dart';
import 'package:project_5_youtube_playlist/screens/favorites.dart';
import 'package:project_5_youtube_playlist/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlist"),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          Align(alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.of<FavoriteBloc>(context).outFav,
              builder: (context, snapshot){
                if (snapshot.hasData){
                  return Text("${snapshot.data.length}");
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.star), 
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>Favorites())
              );
            }
          ),
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());
              if(result != null){
                BlocProvider.of<VideosBloc>(context).inSearch.add(result);
              }
            }
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
        stream: BlocProvider.of<VideosBloc>(context).outVideos,
        initialData: [],
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length +1,
              itemBuilder: (context, index){
                if(index < snapshot.data.length){
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1){
                  BlocProvider.of<VideosBloc>(context).inSearch.add(null);
                  return Container(
                    height: 40, width: 40, alignment: Alignment.center,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                  );
                } else {
                  Container();
                }
              }
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}