import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fitness/components/loading_indicator.dart';
import 'package:fitness/models/Exercise.dart';
import 'package:fitness/services/CallApi.dart';
import 'package:fitness/viewmodel/exercise_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fitness/models/sport_category.dart';
import 'package:fitness/services/app_colors.dart';
import 'package:fitness/services/sharedPreferences.dart';
import 'package:fitness/viewmodel/sport_category_view_model.dart';
import 'package:provider/provider.dart';


class CoachDashboard extends StatefulWidget {
  const CoachDashboard({super.key});

  @override
  State<CoachDashboard> createState() => _CoachDashboardState();
}

class _CoachDashboardState extends State<CoachDashboard> {

  SportCategory? _selectedCategory;
  late TextEditingController _nameController,_descController;
  List<Exercise> suggestions = [];


  @override
  void initState() {
    // TODO: implement initState
    _nameController = new TextEditingController();
    _descController = new TextEditingController();
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((val)async{
      await context.read<ExerciseViewModel>().getExercise().then((val){
        if(val){
          suggestions.addAll(context.read<ExerciseViewModel>().exercises);
        }
      });
      await context.read<SportCategoryViewModel>().getSportCategory().then((val){
        if(val){
        }
      });
    });
  }

  Widget addCategory()=>AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: "new category",
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
          ),
          maxLines: 1,
        ),
        SizedBox(height: 20,),
        TextFormField(
          controller: _descController,
          decoration: InputDecoration(
            hintText: "description",
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
          ),
          maxLines: 5,
        ),
        SizedBox(height: 20,),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                //shadowColor: Colors.greenAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                ),
                //minimumSize: Size(100, 40), //////// HERE
              ),
              onPressed: ()async{
                var data = {
                  "name": _nameController.text,
                  "description": _descController.text
                };

                await context.read<SportCategoryViewModel>().registerSportCategory(context, data).then((val){
                  if(val){
                    Navigator.pop(context);
                  }
                });
              },
              child: Text("Save")
          ),
        )
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text("Coach DashBoard"),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.of(context).pushNamed("/profile",arguments: context.read<AppSharedPreferences>().user);
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.person,size: 50,),
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              builder: (context){
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text("Category"),
                        trailing: TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return addCategory();
                                  }
                              );
                            },
                            child: Text("add")
                        ),
                      ),
                      ListTile(
                        title: Text("Exercise"),
                        trailing: TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      content: VideoPickerAndPreview(),
                                    );
                                  }
                              ).then((val)async{
                                await context.read<ExerciseViewModel>().getExercise();
                              });
                            },
                            child: Text("add")
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<SportCategoryViewModel>(
        builder: (context,sportCategoryViewModel,child){
          return Consumer<ExerciseViewModel>(
            builder: (context,exerciseViewModel,child){
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Categories",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.blue[50]
                                    ),
                                    child: Text("${sportCategoryViewModel.sportCategories.length}"),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context).pushNamed("/liste_sport_cat");
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.blue),
                                          color: Colors.blue[100]
                                      ),
                                      child: Icon(Icons.open_in_browser),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (context){
                                            return addCategory();
                                          }
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.blue),
                                          color: Colors.blue[100]
                                      ),
                                      child: Icon(Icons.add),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,)
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Exercises",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                            Text("${exerciseViewModel.exercises.length}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue)
                            ),
                            child: Column(
                              children: [
                                DropdownButton<SportCategory>(
                                  value: _selectedCategory,
                                  hint: Text('Select a sport category'),
                                  onChanged: (SportCategory? newValue) {
                                    setState(() {
                                      _selectedCategory = newValue;
                                    });
                                  },
                                  items: sportCategoryViewModel.sportCategories.map<DropdownMenuItem<SportCategory>>((SportCategory category) {
                                    return DropdownMenuItem<SportCategory>(
                                      value: category,
                                      child: Text(category.name!),
                                    );
                                  }).toList(),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: suggestions.length,
                                  itemBuilder: (context,index){
                                    return ListTile(
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.black,
                                        child: VideoPreview(
                                          videoPath: suggestions[index].url!,
                                          isNetwork: true,
                                          onTap: () {
                                            // Handle tap
                                          },
                                        ),
                                      ),
                                      title: Text("${suggestions[index].name}"),
                                      //subtitle: Text("${suggestions[index].url}"),
                                      trailing: TextButton(
                                          onPressed: (){
                                            showDialog(
                                                context: context,
                                                builder: (context){
                                                  return AlertDialog(
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        VideoPreview(
                                                          videoPath: suggestions[index].url!,
                                                          isNetwork: true,
                                                          onTap: () {
                                                            // Handle tap
                                                          },
                                                        ),

                                                        SizedBox(height: 10,),
                                                        TextFormField(
                                                          decoration: InputDecoration(
                                                            hintText: "name exercise",
                                                            filled: true,
                                                            fillColor: Colors.white,
                                                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.indigo, width: 2.0),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.red, width: 1.0),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.red, width: 1.0),
                                                            ),
                                                          ),
                                                          maxLines: 1,
                                                        ),
                                                        SizedBox(height: 10,),
                                                        TextFormField(
                                                          decoration: InputDecoration(
                                                            hintText: "Duration",
                                                            filled: true,
                                                            fillColor: Colors.white,
                                                            contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.indigo, width: 2.0),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.red, width: 1.0),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.red, width: 1.0),
                                                            ),
                                                          ),
                                                          maxLines: 1,
                                                        ),
                                                        DropdownButton<SportCategory>(
                                                          value: _selectedCategory,
                                                          hint: Text('Category'),
                                                          onChanged: (SportCategory? newValue) {
                                                            setState(() {
                                                              _selectedCategory = newValue;
                                                            });
                                                          },
                                                          items: context.read<SportCategoryViewModel>().sportCategories.map<DropdownMenuItem<SportCategory>>((SportCategory category) {
                                                            return DropdownMenuItem<SportCategory>(
                                                              value: category,
                                                              child: Text(category.name!),
                                                            );
                                                          }).toList(),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: Colors.red,
                                                                  foregroundColor: Colors.white,
                                                                  //shadowColor: Colors.greenAccent,
                                                                  elevation: 3,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(15.0)
                                                                  ),
                                                                  //minimumSize: Size(100, 40), //////// HERE
                                                                ),
                                                                onPressed: (){

                                                                },
                                                                child: Text("delete")
                                                            ),
                                                            ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: AppColors.primaryColor,
                                                                  foregroundColor: Colors.white,
                                                                  //shadowColor: Colors.greenAccent,
                                                                  elevation: 3,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(15.0)
                                                                  ),
                                                                  //minimumSize: Size(100, 40), //////// HERE
                                                                ),
                                                                onPressed: (){

                                                                },
                                                                child: Text("Save")
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }
                                            );
                                          },
                                          child: Text("Update")
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: sportCategoryViewModel.loadingSportCategories || exerciseViewModel.loadingExercise,
                    child: LoadingIndicator(),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}



/*
class MP4PickerAndPlayer extends StatefulWidget {
  const MP4PickerAndPlayer({Key? key}) : super(key: key);

  @override
  _MP4PickerAndPlayerState createState() => _MP4PickerAndPlayerState();
}

class _MP4PickerAndPlayerState extends State<MP4PickerAndPlayer> {
  String? _filePath;
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  SportCategory? _selectedCategory;
  late TextEditingController _nameController;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
    _nameController.dispose();
  }


  @override
  void initState() {
    super.initState();
    _nameController = new TextEditingController();
  }

  Future<void> _pickAndPlayMP4File() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4'],
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
      });

      // Initialize video player
      _controller = VideoPlayerController.file(File(_filePath!))
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
          _isPlaying = true;
        });
    }
  }

  void _togglePlayPause() {
    if (_controller != null) {
      setState(() {
        if (_isPlaying) {
          _controller!.pause();
        } else {
          _controller!.play();
        }
        _isPlaying = !_isPlaying;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _pickAndPlayMP4File,
            child: Text('Choose File'),
          ),
          SizedBox(height: 20),
          if (_controller != null && _controller!.value.isInitialized)
            Container(
              width: 200,
              height: 200,
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
            )
          else
            Container(
              width: 200,
              height: 200,
              color: Colors.grey,
              child: Center(child: Text('No video selected')),
            ),
          SizedBox(height: 20),
          if (_controller != null && _controller!.value.isInitialized)
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: _togglePlayPause,
            ),

          SizedBox(height: 10,),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "name exercise",
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo, width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
              ),
            ),
            maxLines: 1,
          ),
          SizedBox(height: 10,),
          DropdownButton<SportCategory>(
            value: _selectedCategory,
            hint: Text('Select a sport category'),
            onChanged: (SportCategory? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
            items: context.read<SportCategoryViewModel>().sportCategories.map<DropdownMenuItem<SportCategory>>((SportCategory category) {
              return DropdownMenuItem<SportCategory>(
                value: category,
                child: Text(category.name!),
              );
            }).toList(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  //shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                  //minimumSize: Size(100, 40), //////// HERE
                ),
                onPressed: _selectedCategory == null ? null : ()async{
                  var data = {
                    "name": _nameController.text,
                    "sport_cat_id": _selectedCategory!.sportCatId,
                  };

                  await context.read<ExerciseViewModel>().registerExercise(context, File(_filePath!),data).then((val){
                    if(val){
                      Navigator.pop(context);
                    }
                  });
                },
                child: Text("Save")
            ),
          )
        ],
      ),
    );
  }
}

*/






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




class VideoPickerAndPreview extends StatefulWidget {
  @override
  _VideoPickerAndPreviewState createState() => _VideoPickerAndPreviewState();
}

class _VideoPickerAndPreviewState extends State<VideoPickerAndPreview> {
  String? _filePath;
  VideoPlayerController? _fullScreenController;
  SportCategory? _selectedCategory;
  late TextEditingController _nameController;


  @override
  void initState() {
    super.initState();
    _nameController = new TextEditingController();
  }

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
      });
    }
  }

  void _showFullScreenVideo() {
    if (_filePath != null) {
      _fullScreenController = VideoPlayerController.file(File(_filePath!))
        ..initialize().then((_) {
          _fullScreenController!.play();
          setState(() {});
        });

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: AspectRatio(
              aspectRatio: _fullScreenController!.value.aspectRatio,
              child: VideoPlayer(_fullScreenController!),
            ),
          ),
        ),
      ));
    }
  }

  @override
  void dispose() {
    _fullScreenController?.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _pickVideo,
            child: Text('Pick Video'),
          ),
          SizedBox(height: 20),
          if (_filePath != null)
            VideoPreview(
              videoPath: _filePath!,
              onTap: _showFullScreenVideo,
            ),

          SizedBox(height: 10,),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "name exercise",
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo, width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
              ),
            ),
            maxLines: 1,
          ),
          SizedBox(height: 10,),
          DropdownButton<SportCategory>(
            value: _selectedCategory,
            hint: Text('Select a sport category'),
            onChanged: (SportCategory? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
            items: context.read<SportCategoryViewModel>().sportCategories.map<DropdownMenuItem<SportCategory>>((SportCategory category) {
              return DropdownMenuItem<SportCategory>(
                value: category,
                child: Text(category.name!),
              );
            }).toList(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  //shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                  //minimumSize: Size(100, 40), //////// HERE
                ),
                onPressed: _selectedCategory == null ? null : ()async{
                  var data = {
                    "name": _nameController.text,
                    "sport_cat_id": _selectedCategory!.sportCatId,
                  };

                  await context.read<ExerciseViewModel>().registerExercise(context, File(_filePath!),data).then((val){
                    if(val){
                      Navigator.pop(context);
                    }
                  });
                },
                child: Text("Save")
            ),
          )
        ],
      ),
    );
  }
}
