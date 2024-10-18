import 'dart:io';

import 'package:fitness/models/sport_category.dart';
import 'package:fitness/viewmodel/exercise_view_model.dart';
import 'package:fitness/viewmodel/sport_view_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ViewCatExercise extends StatefulWidget {
  final SportCategory cat;
  const ViewCatExercise({super.key,required this.cat});

  @override
  State<ViewCatExercise> createState() => _ViewCatExerciseState();
}

class _ViewCatExerciseState extends State<ViewCatExercise> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0)).then((val)async{
      await context.read<ExerciseViewModel>().getCategoryExercise(id_cat: widget.cat.sportCatId).then((val){
        if(val){
         // suggestions.addAll(context.read<ExerciseViewModel>().exercises);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.cat.name}"),
        actions: [
          IconButton(
              onPressed: (){
                
              }, 
              icon: Icon(Icons.replay)
          )
        ],
      ),
      body: Consumer<ExerciseViewModel>(
        builder: (context, exerciseViewModel, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: exerciseViewModel.catExercises.length,
            itemBuilder: (context,index){
              return ListTile(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              VideoPreview(
                                videoPath: exerciseViewModel.catExercises[index].url!,
                                isNetwork: true,
                                onTap: () {
                                  // Handle tap
                                },
                              ),

                              SizedBox(height: 10,),
                            ],
                          ),
                        );
                      }
                  );
                },
                leading: Container(
                  height: 50,
                  width: 50,
                  color: Colors.black,
                  child: VideoPreview(
                    videoPath: exerciseViewModel.catExercises[index].url!,
                    isNetwork: true,
                    onTap: () {
                      // Handle tap
                    },
                  ),
                ),
                title: Text("${exerciseViewModel.catExercises[index].name}"),
                //subtitle: Text("${suggestions[index].url}"),
              );
            },
          );
        },
      ),
    );
  }
}


class VideoPreview extends StatefulWidget {
  final String videoPath;
  final bool isNetwork;
  final VoidCallback onTap;

  const VideoPreview({
    Key? key,
    required this.videoPath,
    required this.onTap,
    this.isNetwork = false
  }) : super(key: key);

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  VideoPlayerController? _controller;
  String? _thumbnailPath;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _generateThumbnail() async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: widget.videoPath,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200,
      quality: 75,
    );

    setState(() {
      _thumbnailPath = thumbnailPath;
    });
  }

  Future<void> _initializeVideoPlayer() async {
    _controller = widget.isNetwork
        ? VideoPlayerController.network(widget.videoPath)
        : VideoPlayerController.file(File(widget.videoPath));

    await _controller!.initialize();
    setState(() {});
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller?.pause();
      } else {
        _controller?.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 200,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_thumbnailPath != null)
              Image.file(File(_thumbnailPath!), fit: BoxFit.cover, width: 200, height: 200)
            else
              Container(color: Colors.grey),
            if (_controller != null && _controller!.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
            IconButton(
              icon: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 50,
              ),
              onPressed: _togglePlayPause,
            ),
          ],
        ),
      ),
    );
  }
}